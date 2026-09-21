/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
	Calculate key business metrics (total sales, quantity, orders, products, 
	customers) and consolidate them into a single summary report.

SQL Functions Used:
	SUM, AVG, COUNT, COUNT DISTINCT, UNION ALL, FORMAT

*/
-- Find the total sales
SELECT 
	FORMAT(SUM(sales_amount), 'N')total_sales
FROM gold.fact_sales

-- Find how many items are sold
SELECT 
	SUM(quantity) AS total_quantity
FROM gold.fact_sales

-- Find the average selling price
SELECT 
	AVG(price) AS average_price
FROM gold.fact_sales

-- Find the total number of order
SELECT 
	COUNT( DISTINCT order_number) AS total_orders
FROM gold.fact_sales

-- Find the total number of products
SELECT 
	COUNT(DISTINCT product_key) AS total_number_of_products
FROM gold.dim_products

-- Find the total number of customers
SELECT 
	COUNT(customer_key) total_custoners
FROM gold.dim_customers

-- Find the total number of customers that has place order
SELECT 
	COUNT( DISTINCT customer_key) AS total_customers
FROM gold.fact_sales 

-- Generate a report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name,SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Sales' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products' AS measure_name, COUNT(product_key) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers
