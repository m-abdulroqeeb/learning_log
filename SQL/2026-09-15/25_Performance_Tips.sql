/*============================================================== 
							PERFORMANCE TIPS
 ===============================================================*/

							-- FETCHING DATA
							----------------
--===================================================================
-- Tip 1: Select Only What You Need
--===================================================================

-- Bad practice
SELECT * FROM Sales.Customers

-- Good Practices
SELECT 
	CustomerID, 
	FirstName,
	LastName 
FROM  Sales.Customers

--===================================================================
-- Tip 2: Avoid Unnecessary DISTINCT & ORDER BY
--===================================================================

-- Bad practice
SELECT DISTINCT FirstName
FROM Sales.Customers
ORDER BY FirstName

-- Good Practice
SELECT FirstName
FROM Sales.Customers


--===================================================================
-- Tip 3: For Exploration Purpose, Limit Rows!
--===================================================================

-- Bad Practice
SELECT 
	OrderID,
	Sales
FROM Sales.Orders

-- Good Practice
SELECT TOP 10
	OrderID,
	Sales
FROM Sales.Orders

							-- FILTERING DATA
							----------------

--======================================================================================
-- Tip 4: Create nonclustered index on frequently used columns in WHERE clause
--=======================================================================================

SELECT * FROM Sales.Orders WHERE OrderStatus = 'Delivered'

CREATE NONCLUSTERED INDEX idx_Orders_OrderStatus ON Sales.Orders(OrderStatus)

--======================================================================================
-- Tip 5: Avoid applying Functions to columns in WHERE clause
--=======================================================================================

-- Bad Practice
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'Delivered' -- With the function SQL will not use the index

-- Good practice
SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered'


-- Bad Practice
SELECT * FROM Sales.Customers
WHERE SUBSTRING(FirstName,1,1) = 'A'

-- Good practice
SELECT * FROM Sales.Customers
WHERE FirstName LIKE 'A%'

-- Bad Practice
SELECT * FROM  Sales.Orders
WHERE YEAR(OrderDate) = 2025

-- Good Practice
SELECT * FROM  Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'


--===================================================================
-- Tip 6 : Avoid leading wildcards as they prevent index usage
--===================================================================

-- Bad Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold%' -- SQL avoids using the index due to the leading wildcard

-- Good Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%' -- SQL uses the index



--===================================================================
-- Tip 7: Use IN instead of multiple OR conditions
--===================================================================

-- Bad Practice

SELECT * FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

-- Good Practice

SELECT * FROM Sales.Orders
WHERE CustomerID IN (1,2,3)


							-- JOINING DATA
							-----------------
--===================================================================
-- Tip 8: Understand the speed of joins & use INNER JOIN when possible
--===================================================================

-- Best Performance
SELECT 
	c.FirstName, 
	o.OrderID 
FROM Sales.Customers c 
INNER JOIN Sales.Orders o 
ON  c.CustomerID = o.CustomerID

-- Slower Performance (LEFT JOIN and LEFT OUTER JOIN are identical 
--— "OUTER" is optional and changes nothing)
SELECT 
	c.FirstName, 
	o.OrderID 
FROM Sales.Customers c 
LEFT JOIN Sales.Orders o 
ON  c.CustomerID = o.CustomerID

SELECT 
	c.FirstName, 
	o.OrderID 
FROM Sales.Customers c 
RIGHT OUTER JOIN Sales.Orders o 
ON  c.CustomerID = o.CustomerID

--=================================================================================
-- Tip 9: Use Explicit Join (ANSI Join) Instead of Implicit Join (non-ANSI Join)
--==================================================================================

-- Bad Practice

SELECT o.OrderID,c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID

-- Good Practice

SELECT  o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID

--============================================================================
-- Tip 10: Ensure that the columns used in the ON clause are indexed
--============================================================================

SELECT o.OrderID,c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID

CREATE NONCLUSTERED INDEX idx_Orders_CustomerID ON Sales.Orders(CustomerID)


--===================================================================
-- Tip 11: Filter Before Joining (Big Tables)
--===================================================================

-- Best Practice For Small-Medium Tables
-- Filter After Join (WHERE)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered'

-- Filter During Join (ON)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
   AND o.OrderStatus = 'Delivered'

-- Best Practice For Big Tables
-- Filter Before Join (SUBQUERY)
SELECT * FROM Sales.Customers c
INNER JOIN(
SELECT OrderID, CustomerID
FROM Sales.Orders
WHERE OrderStatus = 'Delivered'
) AS O
ON c.CustomerID = O.CustomerID


--===================================================================
-- Tip 12: Aggregate Before Joining (Big Tables)
--===================================================================

-- Best practice for Small-Medium Table
-- Grouping and joining
SELECT 
	c.CustomerID,
	c.FirstName,
	COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,c.FirstName

-- Best Practice for Big Table
-- Pre-aggregated subquery
SELECT 
	c.CustomerID,
	c.FirstName,
	o.OrderCount
FROM Sales.Customers c
INNER JOIN(
	SELECT 
	CustomerID,
	COUNT(o.orderID) AS OrderCount
	FROM Sales.Orders o
	GROUP BY CustomerID) AS o
ON c.CustomerID = o.CustomerID

-- Bad practice
-- Correlated Subquery
SELECT 
c.CustomerID,
c.FirstName,
(SELECT
COUNT(o.orderID) AS OrderCount
FROM Sales.Orders o
WHERE o.CustomerID = c.customerID) AS OrderCount
FROM Sales.Customers c

--===================================================================
-- Tip 13 : Use UNION Instead of OR while Joining Tables
--===================================================================

-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
OR c.CustomerID = o.SalesPersonID


-- Good Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
UNION 
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.SalesPersonID

--===================================================================
-- Tip 14 : Check for Nested Loops and use SQL HINTS when necessary
--===================================================================
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID


-- Good Practice for having Big Table & Small Table
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
OPTION (HASH JOIN)
								--  UNION
								-----------

--==========================================================================
-- Tip 15 : Use UNION ALL instead of UNION when duplicates are acceptable
--==========================================================================
-- Bad Practice

SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive
-- Good Practice

SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive

--================================================================================================
-- Tip 16 : Use UNION ALL + DISTINCT instead of UNION when duplicates are not acceptable
--================================================================================================
-- Bad Practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

-- Best Practice
SELECT DISTINCT CustomerID
FROM(
	SELECT CustomerID FROM Sales.Orders
	UNION ALL
	SELECT CustomerID FROM Sales.OrdersArchive
) AS CombinedData

								-- AGGREGATING DATA
								---------------------

--==========================================================================
-- Tip 17 : Use COLUMNSTORE INDEX for aggregation on large tables
--==========================================================================

SELECT CustomerID,COUNT(OrderID) AS OrderCount
FROM Sales.Orders
GROUP BY CustomerID

CREATE CLUSTERED COLUMNSTORE INDEX idx_Orders_Columnstore ON Sales.Orders

--==========================================================================
-- Tip 18 : Pre-Aggregate Data and Store it in a New Table for Reporting
--==========================================================================
SELECT MONTH(OrderDATE) AS OrderYear, SUM(Sales) AS TotalSales
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate)


SELECT OrderYear,TotalSales FROM Sales.SalesSummary

								-- SUBQUERIES
								---------------------
--==========================================================================
-- Tip 19 : Choose the Right Method for Filtering with Subqueries (JOIN vs EXISTS vs IN)
--==========================================================================
-- JOIN (Best Practice: If the Performance equals to EXISTS)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'

-- EXISTS (Best Practice: Use it for Large Tables)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE EXISTS (
    SELECT 1
    FROM Sales.Customers AS c
    WHERE c.CustomerID = o.CustomerID
      AND c.Country = 'USA'
)

-- IN (Bad Practice)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE o.CustomerID IN (
    SELECT CustomerID
    FROM Sales.Customers
    WHERE Country = 'USA'
)


--==========================================================================
-- Tip 20 : Avoid Redundant Logic in Your Query
--==========================================================================

-- Bad Practice
SELECT EmployeeID, FirstName, 'Above Average' AS Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT EmployeeID, FirstName, 'Below Average' AS Status
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees)

-- Good Practice
SELECT 
    EmployeeID, 
    FirstName, 
    CASE 
        WHEN Salary > AVG(Salary) OVER () THEN 'Above Average'
        WHEN Salary < AVG(Salary) OVER () THEN 'Below Average'
        ELSE 'Average'
    END AS Status
FROM Sales.Employees


								-- DDL
								---------
/*
=============================================================================
Tip 21: Avoid VARCHAR Data Type If Possible
=============================================================================
Tip 22: Avoid Using MAX or Overly Large Lengths
=============================================================================
Tip 23: Use NOT NULL If Possible 
=============================================================================
Tip 24: Make Sure All Tables Have a CLUSTERED PRIMARY KEY
=============================================================================
Tip 25: Create Nonclustered Index on Foreign Keys if They Are Frequently Used
=============================================================================
*/
-- Bad Practice 
CREATE TABLE CustomersInfo (
    CustomerID INT,
    FirstName VARCHAR(MAX),
    LastName TEXT,
    Country VARCHAR(255),
    TotalPurchases FLOAT, 
    Score VARCHAR(255),
    BirthDate VARCHAR(255),
    EmployeeID INT,
    CONSTRAINT FK_Bad_Customers_EmployeeID FOREIGN KEY (EmployeeID)
        REFERENCES Sales.Employees(EmployeeID)
);

-- Good Practice
CREATE TABLE CustomersInfo (
    CustomerID INT PRIMARY KEY CLUSTERED,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    TotalPurchases FLOAT,
    Score INT,
    BirthDate DATE,
    EmployeeID INT,
    CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
        REFERENCES Sales.Employees(EmployeeID)
);
CREATE NONCLUSTERED INDEX IX_CustomersInfo_EmployeeID
ON CustomersInfo(EmployeeID);


								-- Indexes
								-----------
/*
=============================================================================
Tip 26: Avoid Over-Indexing
=============================================================================
Tip 27: Drop Unused Indexes
=============================================================================
Tip 28: Update Statistics Regularly (Weekly)
=============================================================================
Tip 29: Rebuild & Reorganize (Weekly)
=============================================================================
Tip 30: Partition Large Tables (Facts) to Improve Performance
=============================================================================
*/