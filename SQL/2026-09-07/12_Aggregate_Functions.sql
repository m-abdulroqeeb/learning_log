/* ---------------------------------------------------------------
   AGGREGATE FUNCTION
   --------------------------------------------------------------- 
   This document covers aggregate functions. 
   They are simple but powerful for analytics to bring out insights.
   They are:
		* COUNT
		* SUM
		* AVG
		* MAX
		* MIN
*/

-- COUNT()
-- Find the total number of orders
USE MyDatabase;
SELECT 
	COUNT(*) AS total_nr_Of_orders
FROM Orders
/*COUNT() is used to count the number of rows in a table*/

-- SUM()
-- Find the total sales of all orders
SELECT 
	COUNT(*) AS total_nr_Of_orders,
	SUM(Sales) AS total_Sales
FROM Orders
/*SUM() is used for summation of numeric values in a column of a table in the database*/

-- AVG()
-- Find the average sales of all orders
SELECT 
	COUNT(*) AS total_nr_Of_orders,
	SUM(Sales) AS total_Sales,
	AVG(sales) AS avg_sales
FROM Orders
/* AVG() is used to find the average*/

-- MAX()
-- Find the highest sales of all orders
SELECT 
	COUNT(*) AS total_nr_Of_orders,
	SUM(Sales) AS total_Sales,
	AVG(sales) AS avg_sales,
	MAX(Sales) AS max_sales
FROM Orders
/*To find the highest value*/

-- MIN()
-- Find the lowest sales of all orders
SELECT 
	COUNT(*) AS total_nr_Of_orders,
	SUM(Sales) AS total_Sales,
	AVG(sales) AS avg_sales,
	MAX(Sales) AS max_sales,
	MIN(Sales) AS min_sales
FROM Orders
/*MIN() is used to find the lowest value*/

-- Analyze the scores in customer table
SELECT
	COUNT(*) AS total_nr_of_customers,
	SUM(score) AS total_score,
	AVG(score) AS avg_score,
	MAX(score) AS max_score,
	MIN(score) AS min_score
FROM customers