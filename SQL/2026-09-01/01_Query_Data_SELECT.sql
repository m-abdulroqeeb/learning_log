/* 
---------------------------------------------------------------------------------
SQL SELECT QUERY
---------------------------------------------------------------------------------
This page illustrates my functional and conceptual understanding of the following:
	1. SELECT ALL COLUMNS
	2. SELECT SPECIFIC COLUMNS
	3. WHERE CLAUSE
	4. ORDER BY
	5. GROUP BY
	6. HAVING
	7. DISTINCT
	8. TOP

*/

USE MyDatabase;

-- SELECT ALL COLUMNS
-- Retrieve all customer data
SELECT *
FROM customers;

-- Retrieve All Order Data
SELECT *
FROM orders;

-- Retrieve each customer's name, country, and score
SELECT
	first_name,
	country,
	score
FROM customers;

/*
To select all columns, we use asterisk(*). 
And the columns can be specifically mentioned.
SELECT being the first to be written doesn't mean to be executed first.
The SQL starts execution from FROM, which is the table. 
Then SELECT the concerned columns if not all.*/

-- WHERE
-- Retrieve customers with a score not equal to 0
SELECT *
FROM customers
WHERE score != 0;

-- Retrieve customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany';

/*The WHERE clause is a conditioning statement used to filter.*/


-- ORDER BY
-- Retrieve all customers and sort the results by the highest score
SELECT * 
FROM customers
ORDER BY score DESC;

-- Retrieve all customers and sort the results by the lowest score first
SELECT * 
FROM customers
ORDER BY score ASC;

-- Retrieve all customers and sort the results by the country and then by the highest score
SELECT *
FROM customers
ORDER BY 
	country ASC,
	score DESC;

/*ORDER BY is used to give our query an order, either ascending (ASC) or descending (DESC). 
If the order mechanism is not specified, the default is ascending (ASC).*/


-- GROUP BY
-- Find the total score for each country
SELECT
	country,
	SUM(score) AS total_score
FROM customers
GROUP BY country;

-- Find the total score and the total number of customers for each country
SELECT 
	country,
	SUM(score) AS total_score,
	count(id) AS total_number_of_customers
FROM customers
GROUP BY country;

/* GROUP BY groups rows that share the same value(s) in a column,
   so aggregate functions (SUM, COUNT, AVG, etc.) can be calculated per group
   instead of across the whole table.*/

-- HAVING
/* Find the average score for each country considering only customers with a score not equal to 0.
And return only those countries with an average score greater than 430 */

SELECT 
	country,
	AVG(score) AS AVG_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;

/* HAVING is used to filter but after aggregation, 
   meaning it can only be used with GROUP BY. 
   WHERE, on the other hand, can only be used before aggregation.
*/


-- DISTINCT
-- Return unique list of all countries
SELECT DISTINCT(country) 
FROM customers;

/* DISTINCT is used to remove duplicates from the query output.
  It is not advisable to use unless necessary,
  because it can slow down your query.
*/



-- TOP
-- Retrieve only 3 customers
SELECT TOP 3 *
FROM customers;

-- Retrieve the Top 3 customers with the highest scores
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

-- Retrieve the lowest 2 customers based on the score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

-- Get the two most recent orders
SELECT TOP 2 * 
FROM orders
ORDER BY order_date DESC;

/*TOP helps to output only the first records of the query result*/

-- STATIC VALUE
SELECT 1234  AS number;