/*-------------------------------------------------------------------
                            INDEXES
---------------------------------------------------------------------
This page represents my current understanding of indexes, 
Which will likely be updated as my knowledge about the topic advances.

What is an index?

An index is a data structure that provides quick access to data, 
optimizing the speed of your queries.

Different types of indexes in databases:

Structure:
  - Clustered Index
  - Non-Clustered Index
Storage:
  - Rowstore Index
  - Columnstore Index
Functions:
  - Unique Index
  - Filtered Index

PAGE
----
The smallest unit of data storage in a database (8 KB). 
It can store anything: data, metadata, indexes, etc.

Types of pages:
  - Data Page
  - Index Page: Stores key values (pointers) to another page. 
    It doesn't store the actual rows.

HEAP
----
A table with no index. Fast write, bad read.
To find data, SQL searches every row from the beginning until it finds 
what it's looking for — this is called a Full Table Scan 
(scans the entire table, page by page and row by row).
This is exactly why indexes exist.

CLUSTERED INDEX
----------------
Structured as a B-Tree (Balanced Tree) — a hierarchical structure 
that stores data at its leaves, allowing SQL to quickly locate data 
without scanning every row.

Structure, top to bottom:
  - Root Node: holds a single, top-level index value used to begin the search
  - Intermediate Node(s): hold index values that help navigate toward the 
    correct leaf node
  - Leaf Node: where the actual data is physically stored

NON-CLUSTERED INDEX
---------------------
A separate structure from the actual data — it doesn't reorganize or 
change anything on the data pages themselves. Instead, it holds pointers 
back to where the real data lives.

CLUSTERED VS. NON-CLUSTERED
-----------------------------
- Clustered physically sorts and stores the actual rows; 
  non-clustered is a separate structure with pointers to the data.
- A table can only have ONE clustered index; 
  multiple non-clustered indexes are allowed.
- Clustered has faster read performance than non-clustered.
- Clustered has slower write performance than non-clustered 
  (because writes may require re-sorting physical data).
- Clustered is more storage-efficient; non-clustered requires 
  additional storage space (for the separate index structure).

Clustered Index — Use Cases:
  - Unique columns
  - Columns not frequently modified
  - Improving range query performance

Non-Clustered Index — Use Cases:
  - Columns frequently used in search conditions and joins
  - Exact match queries

HOW TO CREATE AN INDEX
------------------------
In SQL Server, defining a column as PRIMARY KEY automatically creates 
a clustered index on it by default.

A Composite Index includes multiple columns inside a single index.

LEFTMOST PREFIX RULE
-----------------------
An index only helps your query if the filter starts from the first 
column in the index and follows its defined order. 
Column order genuinely matters for composite indexes.

ROWSTORE VS. COLUMNSTORE
---------------------------
- Rowstore stores data row by row; Columnstore stores data column by column.
- [Worth double-checking against your source: original note read 
  "Rowstore has less efficient in storage, and highly efficient with 
  compression" — likely a mix-up. My understanding is Columnstore is the 
  one that's highly storage-efficient due to compression, while Rowstore 
  is comparatively less efficient in storage. Confirm against the course 
  before finalizing.]
- Rowstore has fair speed for both read & write operations; 
  Columnstore has fast read but slow write performance.
- Rowstore has lower I/O efficiency (retrieves all columns); 
  Columnstore has higher I/O efficiency (retrieves only specific columns needed).
- Rowstore is best for OLTP (transactional workloads) — e.g. e-commerce, 
  banking, financial systems, order processing.
  Columnstore is best for OLAP — e.g. data warehousing, business 
  intelligence, reporting, analytics.

Note: A table can only have ONE columnstore index. Rowstore is the default.

Storage efficiency ranking (best to least efficient): 
  1. Columnstore Index
  2. Heap Table
  3. Rowstore

FUNCTIONS
---------

Unique Index:
  Ensures no duplicate values exist in a specific column.
  Benefits: enforces uniqueness, improves performance.

Filtered Index:
  An index that includes only the rows meeting a specified condition.
  Benefits: targeted optimization, reduced storage (less data in the index).

  Restrictions:
  - You cannot create a filtered index on a clustered index; 
    the same restriction applies to a columnstore index.
  - Filtered indexes are only allowed on non-clustered indexes.
  - A filtered index CAN be combined with a unique index.
*/

-- CLUSTERED AND NON-CLUSTERED INDEX

SELECT * 
INTO Sales.DBCustomers
FROM Sales.Customers

SELECT * 
FROM Sales.DBCustomers
WHERE CustomerID = 1

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers(CustomerID)


-- We cannot create more than one clustered index per table (this will error on purpose, to prove it)
CREATE CLUSTERED INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers(FirstName)

DROP INDEX idx_DBCustomers_FirstName ON Sales.DBcustomers

SELECT * FROM Sales.DBCustomers
WHERE LastName = 'Brown'

-- You can have multiple non-clustered indexes on the same table
SELECT * FROM Sales.DBCustomers
WHERE LastName = 'Brown'

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName 
ON Sales.DBCustomers(LastName)

SELECT * FROM Sales.DBCustomers
WHERE FirstName = 'Brown'

CREATE NONCLUSTERED INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers(FirstName)

-- Composite index: an index that includes multiple columns
SELECT * 
FROM Sales.DBCustomers
WHERE Country = 'USA' AND Score > 500

CREATE INDEX idx_DBCustomers_CountryScore 
ON Sales.DBCustomers(country,score)

-- Column and Row
-- DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers

CREATE CLUSTERED COLUMNSTORE INDEX [dx_DBCustomers_CS]
ON Sales.DBCustomers

-- You don't need to specify any column when creating an index if it is COLUMNSTORE and Clustered
DROP INDEX [dx_DBCustomers_CS]
ON Sales.DBCustomers

CREATE NONCLUSTERED COLUMNSTORE INDEX [dx_DBCustomers_CS_FirstName]
ON Sales.DBCustomers(FirstName)


-- Unique Index: ensures no duplicate values exist in a specific column
SELECT * FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX idx_products_product
ON Sales.Products (product)

INSERT INTO Sales.Products(ProductID, Product)
VALUES(106,'Tire')

-- Filtered Index: an index that includes only rows meeting a specified condition
SELECT * FROM Sales.Customers
WHERE Country = 'USA'

CREATE NONCLUSTERED INDEX idxCustomers_Country ON Sales.Customers(Country)
WHERE Country = 'USA'
 
