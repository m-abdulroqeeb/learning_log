/* ---------------------------------------------------
		CREATE TABLE AS SELECT
  ----------------------------------------------------
  This page covers my conceptual and functional understanding of CTAS.
  What is CTAS? Create Table As Select. 
  Creating a new table based on the result of an SQL query

  TABLE TYPES:
 * Permanent Table: Data lives forever as long as you did not drop them. 
   There are two methods of creating permanent tables: CREATE/INSERT & CTAS
 * Temporary tables: Data lives only during the session

	
CTAS Vs. Views
* The query of a view has not yet been executed, while the query of CTAS has already been executed.
* Querying a view is slower than querying a CTAS table
* Views reflect table updates every time they are queried, while CTAS doesn't

Use Cases
* Creating a snapshot
* Physical Data Marts in a data warehouse
* Optimize performance
*/
IF OBJECT_ID('Sales.MonthlyOrders','U') IS NOT NULL
DROP TABLE Sales.MonthlyOrders;
GO
SELECT
	DATENAME(MONTH, OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate)

-- Temp table
SELECT * 
INTO #orders
FROM Sales.Orders


DELETE FROM #orders
WHERE OrderStatus = 'Delivered'

SELECT * 
INTO Sales.OrdersTest
FROM #orders
/* Temp Tables:
 Stores intermediate results in temporary storage within the database during a session.
 What is a session?
 A session is the time between connecting to and disconnecting from the database.

Temp use cases:
To create intermediate results */