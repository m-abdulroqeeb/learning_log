/*
=====================================================================
DDL Script: Create Silver Tables
=====================================================================
Script Purpose:
	Creates the six 'silver' layer tables used to hold cleaned and 
	standardized data, transformed from the bronze layer. Each table 
	includes a dwh_create_date column to track when the record was 
	loaded. Each table is dropped first if it already exists, to allow 
	this script to be re-run safely.

	Tables created:
	- silver.crm_cust_info
	- silver.crm_prd_info
	- silver.crm_sales_details
	- silver.erp_cust_az12
	- silver.erp_loc_a101
	- silver.erp_px_cat_g1v2

*/

IF OBJECT_ID('silver.crm_cust_info') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info(
	cst_id INT, 
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50), 
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.crm_prd_info') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info(
	prd_id INT,
	cat_id NVARCHAR(50),
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.crm_sales_details') IS NOT NULL
	DROP TABLE  silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id NVARCHAR(50),
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.erp_cust_az12') IS NOT NULL
	DROP TABLE silver.erp_cust_az12;
CREATE TABLE silver.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.erp_loc_a101') IS NOT NULL
	DROP TABLE silver.erp_loc_a101;
CREATE TABLE silver.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO


IF OBJECT_ID('silver.erp_px_cat_g1v2') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

