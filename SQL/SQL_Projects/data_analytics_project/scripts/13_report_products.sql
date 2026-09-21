/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
WITH base_query AS
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim_products
---------------------------------------------------------------------------*/
(
SELECT 
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    p.cost,
    s.order_number,
    s.sales_amount,
    s.customer_key,
    s.order_date,
    s.quantity
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
)
,product_aggregate AS (
/*---------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
SELECT 
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    COUNT(DISTINCT order_number) AS total_order,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT customer_key) AS total_customers,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH,MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
    product_key,
    product_name,
    category,
    subcategory,
    cost)
/*---------------------------------------------------------------------------
  3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/
SELECT 
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    total_order,
    total_sales,
     CASE WHEN NTILE(3) OVER(ORDER BY total_sales DESC) = 1 THEN 'High-Performers'
          WHEN NTILE(3) OVER(ORDER BY total_sales DESC) = 2 THEN 'Mid-Range'
          ELSE 'Low-Performers'
    END AS product_segment,
    last_order_date,
    DATEDIFF(MONTH, last_order_date,GETDATE()) AS recency_in_months,
    total_quantity,
    total_customers,
    lifespan,
    -- Average order revenue
    CASE WHEN total_order = 0 THEN 0
         ELSE total_sales/total_order
    END AS average_order_revenue,
    -- Average monthly revenue
    CASE WHEN lifespan = 0 THEN lifespan
         ELSE total_sales/lifespan
    END AS average_monthly_revenue
FROM product_aggregate


