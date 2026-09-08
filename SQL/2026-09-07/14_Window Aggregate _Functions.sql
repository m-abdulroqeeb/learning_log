/*----------------------------------------------------------------------------------
					WINDOW AGGREGATE FUNCTION
 ----------------------------------------------------------------------------------
This page illustrates my understanding of the use of aggregate functions with the window.
It covers the following:
	* COUNT()
	* SUM()
	* AVG()
	* MIN()
	* MAX()
 
 */

-- COUNT()
-- Find the total number of Orders
SELECT 
COUNT(*) AS TotalOrders
FROM Sales.Orders

-- Find the total number of orders, additionally provide details such as order id & order date
SELECT 
OrderID,
OrderDate,
COUNT(*) OVER() AS TotalOrders
FROM Sales.Orders

-- Find the number of orders for each customer
SELECT 
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER() AS TotalOrders,
	COUNT(OrderID) OVER(PARTITION BY CustomerID) AS OrdersByCustomers
FROM Sales.Orders

-- Find the total number of customers, additionally provide all customer's details
SELECT 
	*,
	COUNT(*) OVER() AS TotalNumberOfCustomers
FROM Sales.Customers

-- Find the total number of scores for the customers
SELECT 
	*,
	COUNT(*) OVER() AS TotalCustomers,
	COUNT(Score) OVER() AS TotalScores
FROM Sales.Customers

-- Check whether the table 'orders' contains any duplicate rows
SELECT * FROM (
SELECT 
	OrderID,
	COUNT(*) OVER (Partition By OrderID) AS CheckPK
FROM Sales.Orders
)t
WHERE CheckPK > 1

/* COUNT(): Returns the number of rows within a window. The difference between using * or a column as the argument 
  is that the former will not ignore NULLs, while the latter will ignore them. 
  It can be used to check for data issues like duplicates.

	Use Cases:
	* Overall Analysis
	* Category Analysis
	* Quality Check: Identify NULLs
	* Quality Check: Identify Duplicates
	* Comparison Analysis
	* Outlier Detection
	* Moving Average
	
*/

-- SUM()
-- Find the total sales across all orders and the total sales for each product
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS SalesByProduct
FROM Sales.Orders

-- Comparison Analysis
-- Find the percentage contribution of each product's sales to the total sales
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS TotalSales,
	ROUND(CAST(Sales AS FLOAT)/SUM(Sales) OVER() * 100,2) AS PercentageOfTotal
FROM Sales.Orders
/* SUM(): Returns the sum of values within a window */

-- AVG()
/* Find the average sales across all orders and the average sales for each product.
Additionally provide details such as order id, order date. */

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG(Sales) OVER() AS OverallAvgSales,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgSalesByProduct
FROM Sales.Orders

-- Find the average scores of customers. Additionally, provide details such as Customer ID and LastName
SELECT
	CustomerID,
	LastName,
	AVG(COALESCE(Score,0)) OVER() OverallAvgScores
FROM Sales.Customers

-- Find all orders where sales are higher than the average sales across all orders
SELECT * 
FROM(
SELECT 
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER() AvgSales
FROM Sales.Orders
)t
WHERE Sales > AvgSales
/* AVG(): Returns the average of values within a window */

-- MAX() & MIN()
/*Find the highest & lowest sales across all orders and the highest & lowest sales for each product. 
  Additionally, provide details such as order ID and Order date*/
 SELECT 
	OrderID,
	ProductID,
	Sales,
	MAX(Sales) OVER() HighestSales,
	MIN (Sales) OVER() LowestSales,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSalesByProduct,
	MIN (Sales) OVER(PARTITION BY ProductID) LowestSalesByProduct
FROM Sales.Orders

-- Show the employees who have the highest salaries
SELECT *
FROM(
SELECT 
	*,
	Max(Salary) OVER() HighestSlary
FROM Sales.Employees
)t
WHERE Salary = HighestSlary

-- Calculate the deviation of each sale from both the minimum and maximum sales amount
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() AS HighestSales,
	MIN(Sales) OVER() AS LowestSales,
	Sales - MIN(Sales) OVER() AS DeviationFromMin,
	MAX(Sales) OVER() - Sales AS DeviationFromMax
FROM Sales.Orders

/* MIN() & MAX()
	MIN(): Returns the lowest value within a window.
	MAX(): Returns the highest value within a window.
*/

-- Running & Rolling Total
-- Calculate the moving average of sales for each product over time
SELECT 
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(Sales) OVER( PARTITION BY ProductID ) AS AvgProduct,
	AVG(Sales) OVER( PARTITION BY ProductID Order by OrderDate) AS MovingProduct
FROM Sales.Orders

-- Calculate the moving average of sales for each product over time, including only the next order
SELECT 
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(Sales) OVER( PARTITION BY ProductID ) AS AvgProduct,
	AVG(Sales) OVER( PARTITION BY ProductID Order by OrderDate) AS MovingProduct,
	AVG(Sales) OVER( PARTITION BY ProductID Order by OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM Sales.Orders
/* Running & Rolling Total
	- Running Total: Aggregates all values from the beginning up to the current point without 
	  dropping older data. Running total is the default when only ORDER BY 
	  is used in the window definition.

	- Rolling Total: Aggregates all values within a fixed time window (e.g. 30 days).
	  As new data is added, the oldest data point is dropped.
*/