-- SQL JOINS

-- Retrieve all data from customers and orders as a seperate results
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

-- RIGHT JOIN
-- Get all customers along with their orders,including orders without matching customers
SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id

-- Get all customers alon with their orders, including orders without matching customers(Using the left join)

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

-- LEFT ANTI JOIN
-- Get all customers who haven't placed any order
SELECT * 
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

-- RIGHT ANTI JOIN
-- Get all orders without matching customers
SELECT * 
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Get all orders without matching customers using left join
SELECT *
FROM orders o
LEFT JOIN customers c
on c.id = o.customer_id
WHERE c.id IS NULL

-- FULL ANTI JOIN
-- Find customers without orders and orders without customers
SELECT * 
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL

/* Get all customers along with their orders but only
for customers who have placed an order without using inner join */

SELECT * 
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NOT NULL AND o.customer_id IS NOT NULL

-- CROSS JOIN
-- Generate all possibe combinations of customers and orders
SELECT  * 
FROM customers
CROSS JOIN orders

-- MUTI TABLE JOIN
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
LEFT JOIN sales.Customers c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees e
ON o.SalesPersonID = e.EmployeeID


