
/*-----------------------------------------------------------------------------------------------
	STRING FUNCTIONS
 ------------------------------------------------------------------------------------------------
	In this document, string functions are covered. And what is a function? 
	A built-in SQL code that accepts an input value, processes it, and returns an output value.
	The following functions are:
		* CONCAT
		* UPPER
		* LOWER
		* TRIM
		* REPLACE
		* LEN
		* LEFT & RIGHT 
		* SUBSTRING
 
 */

-- CONCAT
-- Concatenate first name and country into one column
USE MyDatabase;
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ', country) AS first_name_country
FROM customers
/* CONCAT: Combines multiple strings */


-- LOWER
-- Convert the first name to lowercase
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ', country) AS first_name_country,
	LOWER(first_name) AS low_first_name
FROM customers
/* LOWER: Converts all characters to lowercase */

-- UPPER
-- Convert the first name to uppercase
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ', country) AS first_name_country,
	LOWER(first_name) AS low_first_name,
	UPPER(first_name) AS up_first_name
FROM customers
/* UPPER: Converts all characters to uppercase */

-- TRIM
-- Find and trim customers whose first name contains leading or trailing spaces
SELECT 
	first_name,
	TRIM(first_name) trim_first_name,
	LEN(first_name) AS len_first_name,
	LEN(TRIM(first_name))  AS len_trim_first_name,
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name))
-- WHERE first_name != TRIM(first_name)
/* TRIM: Removes leading and trailing spaces */

-- REPLACE
-- Replace dashes (-) in a phone number with slashes
SELECT 
 '123-456-7890' AS phone,
 REPLACE('123-456-7890','-','/') AS clean_phone

 -- Replace file extension from txt to csv
 SELECT 
	'report.txt' AS old_filename,
	REPLACE('report.txt','txt','csv') AS new_filename
/* REPLACE: Replaces a specific character or substring with a new one. 
  It can also be used to remove a specific character by replacing it with an empty string.*/

-- LEN
-- Calculate the length of each customer's first_name
SELECT
	first_name,
	LEN(first_name) AS len_first_name
FROM customers
/* LEN: To know the length of a string in characters */

-- LEFT & RIGHT
-- Retrieve the first two characters of each first name
SELECT 
	first_name,
	LEFT(TRIM(first_name),2) AS first_two_char
FROM customers

-- Retrieve the last two characters of each first name
SELECT 
	first_name,
	LEFT(TRIM(first_name),2) AS first_two_char,
	RIGHT(TRIM(first_name),2) AS last_two_char
FROM customers
/* Used to extract characters from either the left or right of a string */

-- SUBSTRING
-- Retrieve a list of customer's first names removing the first character
SELECT 
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS sub_first_name
FROM customers
/* SUBSTRING: Extracts part of a string starting at a specified position */