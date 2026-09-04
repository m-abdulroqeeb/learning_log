/*------------------------------------------------------------------------
    SET OPERATORS
  ------------------------------------------------------------------------
  Rather than putting the columns side by side (like JOIN), 
  SET operators put rows above each other where the first query determines the column names.
  So in this document set operators are covered, likewise their rules and use cases.
    UNION
    UNION ALL
    EXCEPT
    INTERSECT
 Syntax and Rules
* SET operators can be used in almost all clauses except ORDER BY, which is allowed 
  only at the end of the entire query
* The number of columns in each query must be the same
* The data type of each query must match, or be compatible
* The order of columns in each query must be the same
* The column names in the result set are determined by the column names specified in the first query. 
  That is why if you want to give aliases, you give them in the first query
* Incorrect column selection leads to inaccurate results, even if all rules are met and SQL shows no error. 

UNION USE CASES
* Combine similar information before analyzing the data.
   For instance, you want to know all the individuals in an organization from different silo tables.

EXCEPT USE CASES
 * Delta detection: Identifying the differences or changes (delta) between two batches of data
 * Data completeness check. It can be used to compare tables to detect discrepancies between databases. */

-- UNION
-- Combine the data from employees and customers into one table
SELECT 
	FirstName,
	LastName
FROM Sales.Customers
UNION
SELECT 
	FirstName,
	LastName
FROM Sales.Employees
/* UNION:
    Returns all distinct rows from both queries
    Removes duplicate rows from the result
    The order of the query does not affect the result, 
    but it is necessary to pay attention to the column names.
*/

-- UNION ALL
-- Combines the data from employees and customers into one table, including duplicates
SELECT 
	FirstName,
	LastName
FROM Sales.Customers
UNION ALL
SELECT 
	FirstName,
	LastName
FROM Sales.Employees
/* UNION ALL:
   Returns all rows from both queries including duplicates. 
   It is the only set operator that doesn't remove duplicates. */

-- EXCEPT
-- Find the employees who are not customers at the same time
SELECT 
	FirstName,
	LastName
FROM Sales.Employees
EXCEPT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers
/* EXCEPT:
   Returns all distinct rows that are found in the first query that 
   are not found in the second query. It is the only set operator where 
   we need to pay attention to the order.
*/

-- INTERSECT
-- Find employees who are also customers
SELECT 
	FirstName,
	LastName
FROM Sales.Employees
INTERSECT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers
/*  INTERSECT:
    Returns only rows that are common in both queries
*/

/* Orders are stored in separate tables (Orders and OrdersArchive).
   Combine all orders in one report without duplicates */
SELECT 
    'Orders' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROM  Sales.Orders
UNION
SELECT
    'OrdersArchive' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROM Sales.OrdersArchive