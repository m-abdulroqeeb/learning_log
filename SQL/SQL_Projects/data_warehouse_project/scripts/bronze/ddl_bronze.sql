/*
=====================================================================
DDL Script: Create Bronze Tables
=====================================================================
Script Purpose:
	Creates the six raw ('bronze' layer) tables used to hold source data 
	exactly as it comes from the CRM and ERP systems, before any cleaning 
	or transformation. Each table is dropped first if it already exists, 
	to allow this script to be re-run safely.

	Tables created:
	- bronze.crm_cust_info
	- bronze.crm_prd_info
	- bronze.crm_sales_details
	- bronze.erp_cust_az12
	- bronze.erp_loc_a101
	- bronze.erp_px_cat_g1v2

*/
IF OBJECT_ID('bronze.crm_cust_info') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
	cst_id INT, 
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50), 
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
)
GO

IF OBJECT_ID('bronze.crm_prd_info') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
)
GO

IF OBJECT_ID('bronze.crm_sales_details') IS NOT NULL
	DROP TABLE  bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id NVARCHAR(50),
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
)
GO

IF OBJECT_ID('bronze.erp_cust_az12') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
)
GO

IF OBJECT_ID('bronze.erp_loc_a101') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
)
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
)
GO

