/*------------------------------------------------------------
						 VIEWS
 --------------------------------------------------------------
	What is a view?
A virtual table that is based on the result set of a query,
without storing the data in the database.

	Views Vs. Tables
* Table is hard to maintain, while view is flexible to maintain
* Table has a fast response, view has a slow response
* View has no persistence, while table has persisted data
* With table, you can read and write, but with view, you can only read

	Use Cases
* Central Query Logic. In other words, to store central query
  logic in the database for access by multiple queries.
* Reducing project complexity
* Data Security
* Flexibility & Dynamism
* Offer objects in multiple languages
* For creating virtual data marts in a data warehouse

Views Vs CTE
CTE reduces redundancy in one query, view reduces redundancy across multiple queries
CTE improves reusability in one query, view improves reusability across multiple queries
CTE has temporary logic, and views have persisted logic
CTE needs no maintenance, VIEW needs to be maintained
*/

-- Find the running total of sales for each month
WITH CTE_Monthly_Summary AS
(
SELECT 
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuatities
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate)
)
SELECT
	OrderMonth,
	SUM(TotalSales) OVER(ORDER BY OrderMOnth) AS RunningTotal
FROM CTE_Monthly_Summary;


IF OBJECT_ID('Sales.V_Monthly_Summary','V') IS NOT NULL
	DROP VIEW Sales.V_Monthly_Summary;
GO
CREATE VIEW Sales.V_Monthly_Summary AS
(
SELECT 
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQuatities
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,OrderDate)
);

-- Provide a view that combines details from orders, products, customers, and employees
IF OBJECT_ID('Sales.V_Order_Details','V') IS NOT NULL
	DROP VIEW Sales.V_Order_Details;
GO
CREATE VIEW Sales.V_Order_Details AS(
SELECT 
	o.OrderID,
	o.OrderDate,
	P.Product,
	CONCAT(c.FirstName,' ', c.LastName) CustomerName,
	e.Department,
	c.Country,
	CONCAT(e.FirstName,' ', e.LastName) SalesName,
	o.Sales,
	o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales. Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
)

-- Provide a view for the EU Sales Team 
-- that combines details from all tables 
-- and excludes data related to the USA 
IF OBJECT_ID('Sales.Order_Details_EU','V') IS NOT NULL
	DROP VIEW Sales.Order_Details_EU;
GO
CREATE VIEW Sales.Order_Details_EU AS(
SELECT 
	o.OrderID,
	o.OrderDate,
	P.Product,
	CONCAT(c.FirstName,' ', c.LastName) CustomerName,
	e.Department,
	c.Country,
	CONCAT(e.FirstName,' ', e.LastName) SalesName,
	o.Sales,
	o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales. Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
WHERE c.Country != 'USA'
)

SELECT * FROM Sales.Order_Details_EU