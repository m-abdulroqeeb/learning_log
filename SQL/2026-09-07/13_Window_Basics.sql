/* ---------------------------------------------------------------------------
								WINDOW BASICS
  ---------------------------------------------------------------------------- 
	Window functions: Perform a calculation (aggregate) on a specific subset of 
	data without losing the level of detail of rows. It has the following components: window
	function + window definition (OVER).

							WINDOW Vs. GROUP BY
* Let's assume we want to find a summation. With GROUP BY, the same calculation can be performed
but the level of detail will be reduced. Window function will retain the level of detail of the rows. 
Meaning the granularity remains the same. 
* GROUP BY has only aggregate functions, while WINDOW has more than that — including RANK functions and Value functions.
* GROUP BY is used for simple analysis, WINDOW for advanced analysis

OVER CLAUSE contains the Partition, Order, Frame.

ORDER BY is required for the rank and value functions in WINDOW

Window frame: Defines a subset of rows within each window that is relevant for the calculation. 

Window Frame Rules:
Lower value must be before higher value
Frame clause can only be used together with the ORDER BY clause.

WINDOW FUNCTION Rules:
* Window function can only be used in the SELECT and ORDER BY clause
* Nesting window functions together is not allowed
* SQL executes window functions after the WHERE clause
* Window Function can be used together with GROUP BY in the same query, ONLY if the same columns are used.
  */

-- Find the total sales across all orders
USE SalesDB;
SELECT
	SUM(Sales) AS total_sales
FROM Sales.Orders

-- Find the total sales for each product
SELECT 
	ProductID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY ProductID

-- PARTITION BY
-- Find the total sales for each product, additionally provide details such as order id & order date
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) Over() TotalSales,
	SUM(sales) OVER(PARTITION BY ProductID) AS TotalSalesByProduct
FROM Sales.Orders

-- Find the total sales for each combination of product and order status
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) TotalSalesByStatus
FROM Sales.Orders

-- ORDER BY
/* Rank each order based on their sales from highest to lowest, 
   additionally provide details such as order id & order date */
SELECT
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders

-- Find the total sales for each order status, only for two products 101 and 102
	SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	ProductID,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus) AS TotalSales
FROM Sales.Orders
WHERE ProductID IN (101,102)

-- Rank the customer based on their total sales
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID