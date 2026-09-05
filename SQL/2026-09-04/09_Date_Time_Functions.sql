/*--------------------------------------------------------------------------------------
	DATE & TIME FUNCTIONS
  -------------------------------------------------------------------------------------
  An in depth practicalization of date & time functions. 
  Covering the following:
	* DAY
	* MONTH
	* YEAR
	* DATEPART
	* DATENAME
	* DATETRUNC
	* EOMONTH
	* FORMAT
	* CONVERT
	* CAST
	* DATEADD
	* DATEDIFF
	* ISDATE
	
*/
USE SalesDB;
SELECT 
	OrderID,
	CreationTime
FROM Sales.Orders

-- VALUES
-- USE SalesDB;
SELECT 
	OrderID,
	CreationTime,
	'2026-09-04' AS HardCoded_Date,
	GETDATE() AS Today
FROM Sales.Orders
/*  We have three different sources in order to query date:
	* Date Column from the table
	* Hardcoded Constant String Value
	* GETDATE() FUNCTION which returns the current date and time at the moment the query is executed
*/

-- DAY, MONTH & YEAR
SELECT 
	OrderID,
	CreationTime,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders
/*  DAY(): returns the day from a date
	MONTH(): returns the month from a date
	YEAR(): returns the year from a date
*/

-- DATEPART()
-- Year
SELECT 
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders

--Month
SELECT 
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders

-- Day
SELECT 
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders

-- Hour
SELECT 
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	DATEPART(HOUR, CreationTime) AS Hour_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders

-- Quarter
SELECT 
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	DATEPART(HOUR, CreationTime) AS Hour_dp,
	DATEPART(QUARTER,CreationTime) AS Quarter_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders

-- Weekday
SELECT 
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	DATEPART(HOUR, CreationTime) AS Hour_dp,
	DATEPART(QUARTER,CreationTime) AS Quarter_dp,
	DATEPART(WEEKDAY, CreationTime) AS Weekday_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders

-- Week
SELECT 
	OrderID,
	CreationTime,
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	DATEPART(HOUR, CreationTime) AS Hour_dp,
	DATEPART(QUARTER,CreationTime) AS Quarter_dp,
	DATEPART(WEEKDAY, CreationTime) AS Weekday_dp,
	DATEPART(WEEK,CreationTime) AS week_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders
/* DATEPART(): Returns a specific part of the date. With this, we can extract the week, quarter, weekday, etc.*/

-- DATENAME()
SELECT 
	OrderID,
	CreationTime,
	DATENAME(MONTH,CreationTime) AS Month_dn,
	DATENAME(WEEK,CreationTime) AS Week_dn,
	DATENAME(DAY,CreationTime) AS Day_dn,
	--DATEPART Examples
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	DATEPART(HOUR, CreationTime) AS Hour_dp,
	DATEPART(QUARTER,CreationTime) AS Quarter_dp,
	DATEPART(WEEKDAY, CreationTime) AS Weekday_dp,
	DATEPART(WEEK,CreationTime) AS week_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders
/*  DATENAME(): It returns the name of the datepart...
	It must be pointed out that DATEPART returns an integer while DATENAME returns a string, 
	even if it looks like a number, it's still a string. No calculation can be performed on it. 
	The main function of DATENAME() is to provide human-readable information to the user.*/

--- DATETRUNC()
SELECT 
	OrderID,
	CreationTime,
	--DATETRUNC Examples
	DATETRUNC(MINUTE,CreationTime) AS Minute_dt,
	DATETRUNC(DAY,CreationTime) AS Day_dt,
	DATETRUNC(YEAR,CreationTime) AS Year_dt,
	-- DATENAME Examples
	DATENAME(MONTH,CreationTime) AS Month_dn,
	DATENAME(WEEK,CreationTime) AS Week_dn,
	DATENAME(DAY,CreationTime) AS Day_dn,
	--DATEPART Examples
	DATEPART(YEAR, CreationTime) AS Year_dp,
	DATEPART(MONTH, CreationTime) AS Month_dp,
	DATEPART(DAY, CreationTime) AS Day_dp,
	DATEPART(HOUR, CreationTime) AS Hour_dp,
	DATEPART(QUARTER,CreationTime) AS Quarter_dp,
	DATEPART(WEEKDAY, CreationTime) AS Weekday_dp,
	DATEPART(WEEK,CreationTime) AS week_dp,
	YEAR(CreationTime) AS Year,
	YEAR(GETDATE()) AS ThisYear,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders
/* DATETRUNC(): Truncates a date to a specific part. It keeps only the part or details we consider useful 
   and resets others to 00 if it is a time part and 01 if it is a date part. 
   It is highly useful in data analysis, especially when the level of detail is too high to derive insights.*/

-- EOMONTH()
SELECT 
	OrderID,
	CreationTime, 
	EOMONTH(CreationTime) AS EndOfMonth,
	DATETRUNC(MONTH,CreationTime) StartOfMonth
FROM Sales.Orders
/* EOMONTH(): To return the last day of the month.*/

-- CAST
SELECT 
	OrderID,
	CreationTime, 
	EOMONTH(CreationTime) AS EndOfMonth,
	DATETRUNC(MONTH,CreationTime)AS StartOfMonth,
	CAST(DATETRUNC(MONTH,CreationTime) AS DATE) AS DATE
FROM Sales.Orders
/* CAST() : To convert from one data type to another.*/

-- Data Aggregation
-- How many orders were placed each year?
SELECT 
 YEAR(CreationTime) AS Year,
 COUNT(OrderID) AS NumberOfOrders
FROM Sales.Orders
GROUP BY(YEAR(CreationTime))

-- How many orders were placed each month
SELECT 
	MONTH(CreationTime) AS Month,
	DATENAME(MONTH,CreationTime) AS MonthName,
	COUNT(OrderID) AS NumberOfOrders
FROM Sales.Orders
GROUP BY 
	MONTH(CreationTime),
	DATENAME(MONTH,CreationTime)

-- Data Filtering
-- Show all orders that were placed during the month of February
SELECT *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

-- FORMAT & CASTING
-- DATE FORMAT
SELECT 
	OrderID,
	CreationTime,
	-- US Date Standard
	FORMAT(CreationTime,'MM-dd-yy') AS USA_Format,
	-- European Standard
	FORMAT(CreationTime,'dd-MM-yy') AS EU_Standard,
	--ISO Standard
	FORMAT(CreationTime, 'yy-MM-dd') AS ISO_Format,
	-- days
	FORMAT(CreationTime,'dddd') AS dddd,
	FORMAT(CreationTime,'ddd') AS ddd,
	FORMAT(CreationTime,'dd') AS dd,
	-- months
	FORMAT(CreationTime,'MMMM') AS MMMM,
	FORMAT(CreationTime,'MMM') AS MMM,
	FORMAT(CreationTime,'MM') AS MM
FROM Sales.Orders

/* Show CreationTime using the following format:
	Day Wed Jan Q1 2025 12:34:56 PM */
	
SELECT 
	OrderID,
	CreationTime,
	'Day ' + FORMAT(CreationTime,'ddd MMM ') + 'Q' + 
	DATENAME(QUARTER,CreationTime) + FORMAT(CreationTime, ' yyyy hh:mm:ss tt') AS CustomDate
FROM Sales.Orders

-- Data Aggregation
SELECT 
	FORMAT(OrderDate,'MMM yyyy') AS OrderDate,
	COUNT(*) AS NumberOfOrder
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yyyy')
/*  Date format is case sensitive.
	For instance, MM represents month number and mm represents minutes.*/

-- CONVERT
SELECT 
	CONVERT(INT, '123') AS [String to Int Convert],
	CONVERT(DATE, '2025-08-20') AS [String to Date Convert],
	CONVERT(DATE,CreationTime) AS [DateTime to Date Convert]
FROM Sales.Orders

SELECT 
	CreationTime,
	CONVERT(VARCHAR,CreationTime,32) AS [USA Std. Style: 32],
	CONVERT(VARCHAR,CreationTime,34) AS [EURO Std. Style: 34]
FROM Sales.orders
/* CONVERT: It can be used to cast, as well as format. */

-- CAST
SELECT 
	CAST('123' AS INT) AS [String to INT],
	CAST(123 AS VARCHAR) AS [INT to String],
	CAST('2026-9-04' AS DATE) AS [String to Date],
	CAST('2026-9-04' AS DATETIME2) AS [String to DateTime],
	CreationTime,
	CAST(creationTime AS DATE) AS [DATETIME to Date]
FROM Sales.Orders
/* CAST() : To convert from one data type to another. */

-- Date Calculation
-- DATEADD()
SELECT 
	OrderID,
	OrderDate,
	-- Subtract days
	DATEADD(DAY,-10,OrderDate) AS TenDaysBefore,
	-- Add years
	DATEADD(YEAR,2,OrderDate) AS TwoYearsLater,
	-- Add Months
	DATEADD(MONTH,3,OrderDate) AS ThreeMonthsLater
FROM Sales.Orders
/* DATEADD(): Adds or subtracts a specific time interval to/from a date */

-- DATEDIFF()
-- Find the average Shipping Duration in days for each month
SELECT 
	MONTH(OrderDate) AS OrderDate,
	AVG(DATEDIFF(DAY,OrderDate,ShipDate)) AS AVGShipp
FROM Sales.Orders 
GROUP BY MONTH(OrderDate)
/* DATEDIFF(): Allows us to find the difference between dates */

-- Time Gap Analysis
-- Find the days between each order and the previous order
SELECT 
	OrderID,
	OrderDate AS CurrentOrderDate,
	LAG(OrderDate) OVER(ORDER BY OrderDate) AS PreviousOrderDate,
	DATEDIFF(DAY,LAG(OrderDate) OVER(ORDER BY OrderDate),OrderDate) NrOfDays
FROM Sales.Orders

-- Calculate the age of the employee
SELECT 
	EmployeeID,
	BirthDate,
	GETDATE() AS TodaysDate,
	DATEDIFF(YEAR,BirthDate,GETDATE()) AS EmployeeAge
FROM Sales.Employees

-- Date Validation
-- ISDATE()
SELECT 
	ISDATE(123) AS DateCheck1,
	ISDATE('2025-08-20') AS DateCheck2,
	ISDATE('20-08-2025') AS DateCheck3,
	ISDATE('2025') AS DateCheck4,
	ISDATE('08') AS DateCheck5
/* ISDATE(): Is used to check if a value is a date or not......
   The output is either 1 (valid date) or 0 (not a valid date). It only returns 1 
   if the value meets the date standard of the database*/

SELECT 
    -- CAST(OrderDate AS DATE)
	OrderDate,
	ISDATE(OrderDate),
	CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
		 ELSE '9999-01-01'
	END newOrderDate
FROM
(
SELECT '2025 -08-20' AS OrderDate UNION
SELECT '2025 -08-21' AS OrderDate UNION
SELECT '2025 -08-23' AS OrderDate UNION
SELECT '2025 -08' AS OrderDate
)t
-- WHERE ISDATE(OrderDate) = 0