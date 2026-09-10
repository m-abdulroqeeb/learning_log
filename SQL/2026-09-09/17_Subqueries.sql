/* -----------------------------------------------------------------------
								SUBQUERIES
   -----------------------------------------------------------------------
   Subquery: A query inside another query. 
   Why do we need it?
	* It helps to reduce complexity
	* Make it easy to read
	* It provides a logical flow inside our query

	CATEGORY OF SUBQUERIES:
1. Dependency:
- Non-correlated subquery: A subquery that can run independently from the main query
- Correlated Subquery: A subquery that relies on values from the main query.

	Differences Between Non-correlated and Correlated subqueries
- Non-correlated subquery is easier to read. Correlated is not
- Non-correlated has better performance than the other
- Non-correlated executes only once, while correlated subquery executes multiple times
- Non-correlated can be executed on its own, while the other can't
- Non-correlated is used for static comparisons, filtering with constraints. 
  While the other is used for row-by-row comparisons, dynamic filtering.


2. Result Types:
- Scalar subquery: Return single value
- Row Subquery: Return multiple rows
- Table: Return multiple rows and columns

3. Location (Where the subquery will be used):
- SELECT 
- FROM
- JOIN 
- WHERE (Comparison Operator & Logical Operator)

It must be pointed out that a subquery used in SELECT and 
WHERE clause as a comparison operator must return a scalar value

EXISTS: Check if a subquery returns any rows...Just to check existence
-- Result subquery

Use cases:
- Create Temporary result sets
- Prepare Data Before Joining Tables
- Dynamic & Complex Filtering
- Check the existence of rows from another table using EXISTS
   */


-- WHERE
-- Find the products that have a price higher than the average price of all products
SELECT * 
FROM(
SELECT 
	ProductID,
	Price ,
	AVG(Price) OVER() AvgPriceByProduct
FROM Sales.Products) t
WHERE Price > AvgPriceByProduct

-- Rank the customers based on total amount of sales
SELECT 
	*,
	RANK() OVER(ORDER BY SumOfSalesByCustomers) AS RankCustomers
FROM(
SELECT
	CustomerID,
	SUM(Sales) SumOfSalesByCustomers
FROM Sales.Orders
GROUP BY CustomerID)t

-- SELECT Clause
-- Show the productIDs, names, prices, and total number of orders
SELECT 
	ProductID,
	Product,
	Price,
	-- Subquery
	(SELECT COUNT(OrderID) FROM Sales.Orders) AS TotalOrders
FROM Sales.Products

-- Join Clause
-- Show all customers details and find the total orders for each customer.
--Main Query
SELECT 
	c.*,
	t.Total
FROM Sales.Customers c
LEFT JOIN (
SELECT 
	CustomerID,
	COUNT(*) Total
FROM Sales.Orders
GROUP BY CustomerID)t
ON C.CustomerID = t.CustomerID

-- WHERE clause
-- Find the products that have a price higher than the average price of all products
SELECT 
	ProductID,
	Price,
	(SELECT AVG(Price) FROM Sales.Products) AvgPrice
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

-- WHERE (IN)
-- Show the details of orders made by customers in Germany
SELECT * 
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany')

-- WHERE(ANY)
-- Find female employees whose salaries are greater than the salaries of any male employee
SELECT 
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ANY(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

-- WHERE(ALL)
-- Find female employees whose salaries are greater than the salaries of all male employees
SELECT 
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ALL(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

-- Correlated Subqueries
-- Show all customers details and find the total orders for each customer
SELECT 
	*,
	(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID) TotalSales
FROM Sales.Customers c

-- EXISTS
-- Show the details of orders made by customers in Germany
SELECT * FROM Sales.Orders o
WHERE  EXISTS (
SELECT 1 FROM Sales.Customers c
WHERE Country = 'Germany' AND o.CustomerID = c.CustomerID)