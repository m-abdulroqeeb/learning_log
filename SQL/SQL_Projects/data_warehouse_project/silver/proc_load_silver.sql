/*
========================================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
========================================================================================
Script Purpose:
	Loads data from the bronze layer, cleans and standardizes it, and inserts 
	the result into the silver layer tables. Performs a full reload 
	(TRUNCATE + INSERT) for each table.

	Key transformations applied:
	- Deduplicates customer records, keeping only the most recent record per customer
	- Trims whitespace from text fields
	- Normalizes coded values (marital status, gender, product line, country) 
	  into readable, consistent labels
	- Extracts and derives fields from composite keys (category ID, product key)
	- Validates and casts date fields, setting invalid or malformed dates to NULL
	- Recalculates sales and price values when the original data is missing, 
	  zero, or inconsistent
	- Derives product end dates based on the next product's start date

	Tracks and prints load duration per table, and total batch duration at the 
	end. Wrapped in TRY/CATCH to report errors without crashing silently.

Parameters:
	None. This stored procedure does not accept any parameters and does not 
	return any values.

Usage Example:
	EXEC silver.load_silver
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	SET @batch_start_time = GETDATE()
	BEGIN TRY
		PRINT '===========================================================================================';
		PRINT '>> Loading Silver Layer';
		PRINT '===========================================================================================';

		PRINT '-------------------------------------------------------------------------------------------';
		PRINT '>> Loading CRM Tables';
		PRINT '-------------------------------------------------------------------------------------------';
		SET @start_time = GETDATE()
		PRINT'>> Truncating Table: silver.crm_cust_info'
		TRUNCATE TABLE silver.crm_cust_info;
		PRINT'>> Inserting Table: silver.crm_cust_info'
		INSERT INTO silver.crm_cust_info(
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_marital_status,
			cst_gndr,
			cst_create_date
		)
		SELECT 
			cst_id,
			cst_key,
			TRIM(cst_firstname) AS cst_firstname,
			TRIM(cst_lastname) AS cst_lastname,
			CASE UPPER(TRIM(cst_marital_status))
				WHEN 'M' THEN 'Married'
				WHEN 'S' THEN 'Single'
				ELSE 'n/a'
			END cst_marital_status, -- Nprmalize marital status values to readable format
			CASE UPPER(TRIM(cst_gndr))
				WHEN 'M' THEN 'Male'
				WHEN 'F' THEN 'Female'
				ELSE 'n/a'
			END cst_gndr, -- Normalize gender values to readable format
			cst_create_date
		FROM(
		SELECT 
			*,
			ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
			FROM bronze.crm_cust_info 
			)t
		WHERE flag_last = 1 AND cst_id IS NOT NULL;
		SET @end_time = GETDATE()
		PRINT'>> The Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + ' seconds'
		PRINT'-------------------------------------------------------'
		SET @start_time = GETDATE()
		PRINT'>> Truncating Table: silver.crm_prd_info'
		TRUNCATE TABLE silver.crm_prd_info;
		PRINT'>> Inserting Table: silver.crm_cust_info'
		INSERT INTO silver.crm_prd_info(
			prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt
		)
		SELECT 
			prd_id,
			REPLACE(SUBSTRING(prd_key,1,5), '-','_') AS cat_id, -- Extract Category ID
			SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key, -- Extract product key
			prd_nm,
			COALESCE(prd_cost,0) AS prd_cost,
			CASE UPPER(TRIM(prd_line))
				WHEN 'M' THEN 'Mountain'
				WHEN 'R' THEN 'Road'
				WHEN 'S' THEN 'Other Sales'
				WHEN 'T' THEN 'Touring'
				ELSE 'n/a'
			END prd_line, -- Map product line codes to descriptive values
			CAST(prd_start_dt AS DATE) AS prd_start_dt,
			CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1
			AS DATE) AS prd_end_dt -- Calculte end date as one day before the next start date
		FROM bronze.crm_prd_info
		SET @end_time = GETDATE()
		PRINT'>> The Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + ' seconds'
		PRINT'-------------------------------------------------------'
		PRINT'>> Truncating Table: silver.crm_sales_details';
		TRUNCATE TABLE silver.crm_sales_details;
		PRINT'>> Inserting Table: silver.crm_sales_details';
		INSERT INTO silver.crm_sales_details(
			sls_ord_num,
			sls_prd_key,
			sls_cust_id ,
			sls_order_dt ,
			sls_ship_dt ,
			sls_due_dt ,
			sls_sales ,
			sls_quantity,
			sls_price
		)
		SELECT  
			sls_ord_num, 
			sls_prd_key,
			sls_cust_id, 
			CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8
				THEN NULL
				ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
			END sls_order_dt, 
			CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8
				THEN NULL
				ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
			END sls_shipdt,
			CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8
				THEN NULL
				ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
			END sls_due_dt,
			CASE WHEN sls_sales  IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
				 THEN sls_quantity * ABS(sls_price)
				 ELSE sls_sales
			END AS sls_sales, -- Recalculate sales if original value is missing or incorrect
			sls_quantity,
			CASE WHEN sls_price <= 0 OR sls_price IS NULL  
				 THEN sls_sales /NULLIF(sls_quantity,0)
				 ELSE ABS(sls_price)
			END AS sls_price --- Derive price if original price is invalid
		FROM bronze.crm_sales_details ;
		SET @end_time = GETDATE()
		PRINT'>> The Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + ' seconds'
		PRINT'-------------------------------------------------------'
		SET @start_time = GETDATE()
		PRINT'>> Trncating Table: silver.erp_cust_az12'
		TRUNCATE TABLE silver.erp_cust_az12;
		PRINT'>> Inserting Table: silver.erp_cust_az12'
		INSERT INTO silver.erp_cust_az12(
			cid,
			bdate,
			gen 
		)
		SELECT 
			CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4, LEN(cid))
				 ELSE cid
			END AS cid, --Remove 'NAS' prefix if present
			CASE WHEN bdate > GETDATE() THEN NULL
			ELSE bdate
			END bdate, -- Srt Future birthdate to NULL
			CASE WHEN UPPER(TRIM(gen)) IN ('F','Female') THEN 'Female'
				 WHEN UPPER(TRIM(gen)) IN ('M','Male') THEN 'Male'
			ELSE 'n/a'
			END AS gen -- Normalize gender values and handle unknown cases
		FROM bronze.erp_cust_az12
		SET @end_time = GETDATE()
		PRINT'>> The Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + ' seconds'
		PRINT'-------------------------------------------------------'
		SET @start_time = GETDATE() 
		PRINT'>> Trucating Table: silver.erp_loc_a101'
		TRUNCATE TABLE silver.erp_loc_a101;
		PRINT'>> Inserting Table: silver.erp_loc_a101'
		INSERT INTO silver.erp_loc_a101(
			cid ,
			cntry 
		)
		SELECT 
		REPLACE(cid, '-','') AS cid,
		CASE WHEN TRIM(cntry) IN ('DE','Germany') THEN 'Germany'
			 WHEN TRIM(cntry) IN ('USA','United States','US') THEN 'United States'
			 WHEN TRIM(cntry) = 'Australia' THEN 'Australia'
			 WHEN TRIM(cntry) = 'United Kingdom' THEN 'United Kingdon'
			 WHEN TRIM(cntry) = 'France' THEN 'France'
			 WHEN TRIM(cntry) = 'Canada' THEN 'Canada'
			 ELSE 'n/a'
		END AS cntry --	Normalize and handle missing or blank country codes
		FROM bronze.erp_loc_a101
		SET @end_time = GETDATE()
		PRINT'>> The Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + ' seconds'
		PRINT'-------------------------------------------------------'
		PRINT'>> Truncating Table: silver.erp_px_cat_g1v2'
		TRUNCATE TABLE silver.erp_px_cat_g1v2;
		PRINT'>> Inserting Table: silver.erp_px_cat_g1v2'
		INSERT INTO silver.erp_px_cat_g1v2(
			id ,
			cat ,
			subcat,
			maintenance
		)
		SELECT
			id ,
			cat ,
			subcat,
			maintenance
		FROM bronze.erp_px_cat_g1v2	
		SET @end_time = GETDATE()
		PRINT'>> The Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + ' seconds'
		SET @batch_end_time = GETDATE()
		
		PRINT'===============================================================================================================';
		PRINT'>> Loading Silver Layer is completed '
	    PRINT'>> Total Load Duration : '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	    PRINT'================================================================================================================';
	END TRY
	BEGIN CATCH
		PRINT'====================================================='
		PRINT'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT'====================================================='
		PRINT'Error Message: ' + ERROR_MESSAGE()
		PRINT'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(50))
		PRINT'Error State: ' + ERROR_STATE()
		PRINT'Error Line: ' + CAST(ERROR_LINE() AS  NVARCHAR(50))
	END CATCH
END

