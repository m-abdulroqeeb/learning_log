/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
	Rank products and customers by performance to identify top and bottom 
	performers, comparing a simple TOP N approach against the same 
	analysis done with a window function.

SQL Functions Used:
	TOP, ROW_NUMBER, GROUP BY, LEFT JOIN
*/
-- Which 5 products generate the highest revenue
SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
	FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- Using Window Function
SELECT * FROM (
SELECT
	p.product_name,
	SUM(s.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER( ORDER BY SUM(s.sales_amount) DESC) AS rank_product
	FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
)t 
WHERE rank_product <= 5

-- what are the 5 worst-performing products in terms of sales
SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
	FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC

-- Using Window Function
SELECT * FROM (
SELECT 
	p.product_name,
	SUM(s.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER( ORDER BY SUM(s.sales_amount) ASC) AS rank_product
	FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
)t 
WHERE rank_product <= 5

-- Find the Top-10 customers who have generated the highest revenue
SELECT * FROM (
SELECT 
	s.customer_key,
	c.first_name,
	c.last_name,
	SUM(sales_amount) AS total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(sales_amount) DESC) AS rank_customer
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY 
	s.customer_key,
	c.first_name,
	c.last_name
)t
WHERE rank_customer <= 10;
-- and three customers with the fewest orders
SELECT * FROM (
SELECT 
	s.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT s.order_number) AS total_orders,
	ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT s.order_number) ASC) AS lowest_rank_order
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY 
	s.customer_key,
	c.first_name,
	c.last_name
)t
WHERE lowest_rank_order <= 3

