/*--------------------------------------------------------------- 
	NULL FUNCTIONS
  ---------------------------------------------------------------
	What is NULL?
	NULL means nothing, unknown. It must be pointed out that NULL is 
	not equal to anything! NULL is not zero, NULL is not an empty string, 
	and NULL is not a blank space.

    In order to replace NULL with a value, we have two functions: ISNULL and COALESCE. 
	And if you want to replace a value with a NULL, we use NULLIF.

    If we just want to check if we have a NULL, we use IS NULL...
	The output is either TRUE or FALSE.

    ISNULL takes two arguments which are: the concerned column and the default value to replace the nothing.

    COALESCE: It returns the first non-null value from a list. 
	It takes more values than ISNULL. It does what ISNULL does and more. 
	By that I mean there can be more than one value for the replacement of the NULL.

	ISNULL Vs. COALESCE
	ISNULL is faster than COALESCE
	ISNULL behaves differently across many databases, while COALESCE is universal. 
	Meaning COALESCE is more advisable to use.
	(I'm using COALESCE throughout this practice for that reason, instead of ISNULL.)

	Use cases for both ISNULL Vs. COALESCE
	To handle the NULL before data aggregation.
	To handle the NULL before doing mathematical operations
	JOIN: NULL against NULL while inner joining tables cannot be verified by the database, so it will be unmatched
	SORTING

	NULLIF: Compares two expressions, returns NULL if they are equal, and the first value if they are not. 
	Use cases:
	It can be used to flag special cases without data
	Preventing the error of dividing by zero

	IS NULL returns TRUE if the value is NULL, otherwise FALSE.
	IS NOT NULL returns TRUE if the value is NOT NULL, otherwise it returns FALSE

	Use Cases for IS NULL and IS NOT NULL:
	Data filtering
	ANTI JOIN: to find unmatched rows between tables
*/

-- COALESCE
-- Find the average scores of the customers
SELECT 
	CustomerID,
	Score,
	COALESCE(Score,0) Score2,
	AVG(Score) OVER() AVGCustomerScore,
	AVG(COALESCE(Score,0)) OVER () AVGCustomerScore2
FROM Sales.Customers

/* Display the full name of customers in a single field by merging
   their first and last names, and add 10 bonus points to each customer's score */
SELECT 
	CustomerID,
	FirstName,
	LastName,
	CONCAT(FirstName,' ', LastName)  AS FullName,
	Country,
	Score,
	Score + 10 ScoreWithBonus,
	COALESCE(Score,0) + 10 AS ScoreWithBonus2
FROM Sales.Customers

-- Sort the customers from lowest to highest scores, with NULL appearing last.
-- Lazy way
SELECT 
CustomerID,
Score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY COALESCE(Score,99999)

-- Professional way
SELECT 
CustomerID,
Score
FROM Sales.Customers
ORDER BY 
CASE WHEN Score IS NULL THEN 1 ELSE 0 END 

-- NULLIF
-- Find the sales price for each order by dividing the sales by the quantity
SELECT * FROM Sales.Orders

SELECT 
	OrderID,
	Quantity,
	Sales,
	Sales / NULLIF(Quantity,0) AS SalesPrice
FROM Sales.Orders

-- IS NULL and IS NOT NULL
-- Identify customers who have no score
SELECT * 
FROM Sales.Customers
WHERE Score IS NULL

-- List all customers who have scores
SELECT * 
FROM Sales.Customers
WHERE Score IS NOT NULL

-- List all details for customers who have not placed any order
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	c.Country,
	c.score,
	o.OrderID,
	o.CustomerID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL