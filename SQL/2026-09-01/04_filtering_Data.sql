/*
--------------------------------------------------------------------------------
SQL DATA FILTERING
-------------------------------------------------------------------------------
This document covers the following:
Comparison Operator
Logical Operator
Range Operator
Membership Operator
Search Operator

*/


-- Comparison Operator
-- Rerieve all customers from Germany
SELECT * 
FROM customers
WHERE country = 'Germany'

-- Retrieve all customers who are not from Germany
SELECT * 
FROM customers
WHERE country != 'Germany'
-- WHERE country <> 'Germany'

-- Retrieve all customers with a score greater than 500
SELECT * 
FROM customers
WHERE score > 500

-- Retrieve all customers with a score of 500 or more
SELECT * 
FROM  customers
WHERE score >= 500

-- Retrieve all customers with a score less than 500
SELECT * 
FROM customers
WHERE score < 500

--Retrieve all customers  with a score of 500 or less
SELECT * 
FROM customers
WHERE score <= 500

/* The comparison operators are:  =, <>, >, >=, <, <= */


-- Logical Operator

-- AND
/* Retrieve all customers who are from USA and have a score greater than 500 */
SELECT * 
FROM customers
WHERE country = 'USA' AND score > 500

-- OR
-- Retrieve all Customers who are either from USA OR have a score less than 500
SELECT * 
FROM customers
WHERE country = 'USA' OR score < 500

-- NOT(Exclude matching rows)
-- Retrieve all customers with a score NOT less than 500
SELECT * 
FROM customers
WHERE NOT score < 500

/*
AND: All conditions must be true
OR: At least one condition must be true
NOT: returns rows where the condition is false */


-- Range Operator

--BETWEEN
-- Retrieve all customers whose score fall in the range between 100 and 500
SELECT * 
FROM customers
WHERE score BETWEEN 100 AND 500

/* SELECT * 
FROM customers
WHERE score >= 100 AND score <= 500 */

/*
  BETWEEN: Check if a value is between a range. 
  It has upper and lower boundary, and both are inclusive in the output 
  */


-- Membership Operator

-- IN
--Retrieve  all customers from either Germany or USA
SELECT * 
FROM customers
WHERE country IN ('Germany','USA')

/* 
	SELECT * 
	FROM customers
	WHERE country = 'Germany' OR country = 'USA'
*/

/* IN: Check if a value exists in a list */

-- Search Operator

-- LIKE
-- Find all customers whose first name starts with 'M'
SELECT * 
FROM customers
WHERE first_name LIKE 'M%'

-- Finds all customers whose first name ends with 'n'
SELECT * 
FROM customers
WHERE first_name LIKE '%n'

-- Finds all customers whose first name contains 'r'
SELECT * 
FROM customers
WHERE first_name LIKE '%r%'

-- Finds all customers whose first name has 'r' in the third position
SELECT * 
FROM customers
WHERE first_name LIKE '__r%'

/* LIKE: Search for pattern in a text. This can be done using % or _, 
   where  the former means anything and the latter means exact*/

 
