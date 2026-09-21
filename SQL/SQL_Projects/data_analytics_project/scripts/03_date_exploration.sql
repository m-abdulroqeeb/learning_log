/*
===============================================================================
							Date Range Exploration 
===============================================================================
Purpose:
	Explore the date boundaries in the data — how far back the sales data 
	goes, and the age range of customers.

SQL Functions Used:
	MIN, MAX, DATEDIFF

*/

-- Find the date of the first and last order
-- How many years of sales are available
-- How many months of sales are available
SELECT 
	MIN(order_date) first_order_date, 
	MAX(order_date) last_order_date,
	DATEDIFF(YEAR, MIN(order_date),MAX(order_date)) AS order_range_years,
	DATEDIFF(MONTH, MIN(order_date),MAX(order_date)) AS order_range_months
FROM gold.fact_sales

-- Find the yougest and oldest customer.
SELECT 
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_customer,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_customer
FROM gold.dim_customers

