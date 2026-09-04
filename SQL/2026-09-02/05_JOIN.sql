/* ---------------------------------------------------------------------
	SQL JOINS
   --------------------------------------------------------------------- 
   JOIN is one of the most important concepts in SQL. 
   On this page I explored both its conceptual and practical aspects. 
   The following types of JOIN are covered:
		1. INNER
		2. LEFT
		3. RIGHT
		4. FULL JOIN
		5. LEFT ANTI JOIN
		6. RIGHT ANTI JOIN
		7. FULL ANTI JOIN
		8. CROSS JOIN
	*/

-- Retrieve all data from customers and orders as separate results
SELECT * 
FROM customers;
SELECT * 
FROM orders;

-- INNER JOIN
/* Get all customers along with their orders, 
but only for customers who have placed an order */
SELECT
	 c.id,
	 c.first_name,
	 o.order_id,
	 o.sales
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id

/* With INNER JOIN, only the matching records are output.
   This is also the default, if only JOIN is mentioned, without the type.*/

-- LEFT JOINS
-- Get all customers along with their orders, including those without orders

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers c
LEFT JOIN orders o 
ON c.id = o.customer_id

/* Return all the rows from the left table and only the matching from
   the right. It must be pointed out that the order is very important....
   The left table is picked immediately and then it searches if the right matches or not...
   if it doesn't, it will be null.
*/


-- RIGHT JOIN
-- Get all customers along with their orders, including orders without matching customers
SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id

/* Returns all rows from the right and only matching from the 
   left table. By changing the order of the tables in the query 
   we can achieve a RIGHT JOIN result using LEFT JOIN and vice versa. As seen below
*/

-- Get all customers along with their orders, including orders without matching customers (using the left join)
SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders o
LEFT JOIN customers c
ON c.id = o.customer_id

-- FULL JOIN
-- Get all customers and all orders, even if there is no match
SELECT * 
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id

/* Full Join: The order of the tables is not important.
   It returns all records from both tables */

-- LEFT ANTI JOIN
-- Get all customers who haven't placed any order
SELECT * 
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

/* LEFT ANTI JOIN: Returns rows from the left table that have no match in the right...
   To achieve this we use the WHERE filter. The order of the tables is important */

-- RIGHT ANTI JOIN
-- Get all orders without matching customers
SELECT * 
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL
/* RIGHT ANTI JOIN: Returns rows from the right table that have no match in the left...
   The order of the tables is very important */

-- Get all orders without matching customers using left join
SELECT *
FROM orders o
LEFT JOIN customers c
ON c.id = o.customer_id
WHERE c.id IS NULL

-- FULL ANTI JOIN
-- Find customers without orders and orders without customers
SELECT * 
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL

/* Get all customers along with their orders but only
for customers who have placed an order, without using inner join */
SELECT * 
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NOT NULL AND o.customer_id IS NOT NULL


/* Returns only the rows that don't match in either table.... 
   it is the opposite of inner join */

-- CROSS JOIN
-- Generate all possible combinations of customers and orders
SELECT  * 
FROM customers
CROSS JOIN orders
/* CROSS JOIN: combines every row from the left with every row from the right...
   We don't need an ON condition since we are looking for all possible combinations */

-- MULTI TABLE JOIN
/* Using SalesDB, Retrieve a list of all orders, along with the related customer,
   product, and employee details. For each order display the following:
	* Order ID
	* Customer's name
	* Product name
	* Sales amount 
	* Product price
	* Salesperson's name
*/

USE SalesDB;
SELECT
	o.OrderID,
	o.Sales,
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	p.Product AS ProductName,
	p.Price,
	e.FirstName AS EmployeeFirstName,
	e.LastName AS EmployeeLastName
FROM Sales.Orders o
LEFT JOIN Sales.Customers c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees e
ON o.SalesPersonID = e.EmployeeID