/*
===============================================================================
						Dimensions Exploration
===============================================================================
Purpose:
	Explore the distinct values within key dimension tables, to understand 
	the range of customers and products in the business.

SQL Functions Used:
	DISTINCT

*/

-- Explore all countries our customers come from
SELECT 
DISTINCT country 
FROM gold.dim_customers

-- Explore all product categoroies inside oyr business
SELECT DISTINCT 
	category, 
	subcategory, 
	product_name 
FROM gold.dim_products
ORDER BY 1,2,3

