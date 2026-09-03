-- SQL FUNCTION
-- String Function

-- CONCAT
-- Concatenate first name and country into one colummn
USE MyDatabase;
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ', country) AS first_name_country
FROM customers

-- UPPER
-- Convert the first name to lowercase
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ', country) AS first_name_country,
	LOWER(first_name) AS low_first_name
FROM customers

-- LOWER
-- Convert the first name to uppercase
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ', country) AS first_name_country,
	LOWER(first_name) AS low_first_name,
	UPPER(first_name) AS up_first_name
FROM customers

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

-- REPLACE
-- Remove dashes (-) from a phone number
SELECT 
 '123-456-7890' AS phone,
 REPLACE('123-456-7890','-','/') AS clean_phone

 -- Replace File Extence from txt to csv
 SELECT 
	'report.txt' AS old_filename,
	REPLACE('report.txt','txt','csv') AS new_filename

-- LEN
-- Calculate the length of each customer's first_name

SELECT
	first_name,
	LEN(first_name) AS len_first_name
FROM customers

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

-- SUBSTRING
-- Retrieve a list of customer's first names removing the first character
SELECT 
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS sub_first_name
FROM customers

