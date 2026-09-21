

/*
===============================================================================
                            Database Exploration
===============================================================================
Purpose:
	Explore the database's structure — listing all tables and the columns 
	within a specific table.

Table Used:
	INFORMATION_SCHEMA.TABLES, INFORMATION_SCHEMA.COLUMNS

*/

-- Explore a list of all tables in the database
SELECT 
    *
FROM INFORMATION_SCHEMA.TABLES;

-- Explore all columns for a specific table(dim_customer)
SELECT 
    *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';