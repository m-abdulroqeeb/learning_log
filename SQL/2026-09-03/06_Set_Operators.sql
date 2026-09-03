-- SET OPERATORS

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

-- EXCEPT
-- Find the employees who are not customers at the sametime
SELECT 
	FirstName,
	LastName
FROM Sales.Employees
EXCEPT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

-- INTERSECT
-- Find employees who are also customer
SELECT 
	FirstName,
	LastName
FROM Sales.Employees
INTERSECT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

/* Orders are stored in seperate tables(Orders and OrdersArhive).
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
FROM Sales.OrdersArchive

