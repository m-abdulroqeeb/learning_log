/*--------------------------------------------------------------
	WINDOW VALUE FUNCTION
 ---------------------------------------------------------------
	* LEAD(): Access a value from the next row within a window. No frame
	* LAG(): Access a value from the previous row within a window. No frame
	* FIRST_VALUE(): Access a value from the first row within a window. Frame is optional
	* LAST_VALUE(): Access a value from the last row within a window. You have to customize the frame.
	  Frame should be used

	 ORDER BY clause is required in all, just as the rank functions.
	 It works with all data types, PARTITION clause is optional in all. 

	 Use Cases:
	 Time Series Analysis
	 Customer Retention Analysis
	 Comparison Analysis
 */

 -- Time Series Analysis
 /*Analyse the month-over-month (MoM) performance by finding the
   percentage change in sales between current and previous months */
SELECT 
	* ,
	CurrentMonthSales - PreviousMonthSales AS MoM_Change,
	ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100,1) AS MoM_Perc
FROM(
SELECT
	Month(OrderDate) As Month,
	SUM(Sales)  AS CurrentMonthSales,
	Lag(SUM(Sales)) OVER( ORDER BY Month(OrderDate)) AS PreviousMonthSales
FROM Sales.Orders
GROUP BY
	Month(OrderDate)
)t


-- Customer Retention Analysis
-- Analyze customer loyalty by ranking customers based on the average number of days between orders
SELECT
	CustomerID,
	AVG(DaysUntilNextOrder) AvgDaysUntilNextOrder,
	RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder),999999)) AS RankAvgDaysUntilNextOrder
FROM( 
SELECT 
	OrderID,
	CustomerID,
	OrderDate AS CurrentOrder,
	LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
	DATEDIFF(day,OrderDate,Lead(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
FROM Sales.Orders
) t
GROUP BY CustomerID

-- FIRST_VALUE/LAST_VALUE
-- Find the lowest and highest sales for each product
-- Find the difference between the current and lowest sales
SELECT 
	OrderID,
	ProductID,
	Sales AS CurrentSales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
	-- MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSales2,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales,
	-- MAX(Sales) OVER(PARTITION BY ProductID) AS HighestSales,
	Sales - MIN(Sales) OVER(PARTITION BY ProductID) AS SalesDifference
FROM Sales.Orders