/*-------------------------------------------------------------------------------------------
							COMMON TABLE EXPRESSION
 -------------------------------------------------------------------------------------------
CTE (Common Table Expression):
Temporary, named result set (virtual table), that can be used multiple times 
within your query to simplify and organize complex queries.

It has two main features:
* It does not live long. Meaning it is destroyed the moment the query is executed
* It is not globally available.

Diff. Between Subquery and CTE
Subquery is written from Bottom to Top, while CTE is written from Top to Bottom
For the subquery, the result can be used only once, while CTE can be used in many places in the query.

Why CTE?
* Modularity: Pieces are easy to manage, develop, and self-contained
* Reusability: Reduce redundancy in query
* Readability: Break down complex queries into smaller pieces
* Recursive: Iterations or looping in SQL

CTE Types:
* Non Recursive: executed only once without any repetition. It can be classified into Stand Alone CTE & Nested CTE
 - Stand Alone CTE: Defined and used independently. 
   Runs independently as it is self-contained and doesn't rely on other CTEs' queries.
 - Nested: CTE inside another CTE. It uses the result of another CTE, meaning it can't run independently
* Recursive: Self-referencing query that repeatedly processes data until a specific condition is met.
  In recursive CTE, the first query is the one that interacts with the database 
  and it is called the Anchor query, and it is executed only once. 
  The second query is called the recursive query. 
  To determine the number of recursions, we use OPTION(MAXRECURSION).

It must be pointed out that all clauses can be used inside the CTE except ORDER BY

CTE Best Practices
* Rethink and refactor your CTEs before starting a new one
* Don't overuse the CTE. At most 5. */

-- Non Recursive CTE
-- STEP 1: Find the total sales per customer
WITH CTE_Total_Sales AS
(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
-- STEP 2: Find the last order date for each customer
, CTE_Last_Order AS
(
SELECT
	CustomerID,
	MAX(OrderDate) AS Last_Order
FROM Sales.Orders
GROUP BY CustomerID
),
-- STEP 3: Rank customers based on total sales per customer
CTE_Customer_Rank AS
(
SELECT 
	CustomerID,
	TotalSales,
	RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
FROM  CTE_Total_Sales
),
-- STEP 4: Segment the customers based on their total sales
CTE_Customer_Segements AS
(
SELECT 
CustomerID,
TotalSales,
CASE WHEN TotalSales > 100	THEN 'High'
	 WHEN TotalSales > 50 THEN 'Medium'
	 ELSE 'Low'
END CustomerSegments
FROM CTE_Total_Sales
)
-- SELECT * FROM CTE_Customer_Segements
-- Main query
SELECT 
	c.CustomerID,
	c.FirstName,
	C.LastName,
	cts.TotalSales,
	ctr.CustomerRank,
	ccs.CustomerSegments,
	clo.Last_Order
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ctr
ON ctr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segements ccs
ON ccs.CustomerID = c.CustomerID;

-- Recursive CTE
-- Generate a sequence of numbers from one to twenty
WITH Series AS(
-- Anchor query
SELECT 
	1 AS MyNumber
UNION ALL
--Recursive query
SELECT 
	MyNumber + 1
FROM Series
WHERE MyNumber < 20
)
-- Main query
SELECT * 
FROM Series;
-- OPTION(MAXRECURSION 10)

-- Show employee hierarchy by displaying each employee's level within the organisation
WITH CTE_Emp_Hierarchy AS
(
-- Anchor Query
SELECT 
	EmployeeID,
	FirstName,
	LastName,
	ManagerID,
	1 AS Level
FROM Sales.Employees s
WHERE ManagerID IS NULL
UNION ALL
-- Recursive query
SELECT 
	e.EmployeeID,
	e.FirstName,
	e.LastName,
	e.ManagerID,
    level +1 
FROM Sales.Employees AS e
INNER JOIN CTE_Emp_Hierarchy ceh
ON e.ManagerID = ceh.EmployeeID
)
-- Main query
SELECT * FROM CTE_Emp_Hierarchy;