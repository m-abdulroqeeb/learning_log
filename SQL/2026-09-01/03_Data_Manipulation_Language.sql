/*
---------------------------------------------------------------------------
Data Manipulation Langauge (DML)
---------------------------------------------------------------------------
Manipulating data involves the use of key words, such as:
    INSERT: To add data to a table
    UPDATE: To change an existing value in table
    DELETE: To delete rows or records in table
*/

-- INSERT
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100)

-- correct column order 
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (8, 'Max', 'USA', NULL)
    
-- Incorrect data type in values
INSERT INTO customers (id, first_name, country, score)
VALUES 
	('Max', 9, 'Max', NULL)

-- Insert a new record with full column values
INSERT INTO customers (id, first_name, country, score)
VALUES (8, 'Max', 'USA', 368)

-- Insert a new record without specifying column names (not recommended)
INSERT INTO customers 
VALUES 
    (9, 'Andreas', 'Germany', NULL)
    
-- Insert a record with only id and first_name
INSERT INTO customers (id, first_name)
VALUES 
    (10, 'Sahra')

-- Copy data from 'customers' table into 'persons'
INSERT INTO persons(id,person_name,birth_date,phone)
SELECT 
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers

/*INSERT is used to add data to a table. It is advisable for the specific columns to be mentioned, 
to avoid confusion and error. Although you don't have to specify the columns if you are inserting values to all.
It can also be used to copy the data from table to another, 
provided that they have the same number of columns.*/

--Updates
-- Change the score of customer with ID 6 to 0
SELECT * FROM customers

UPDATE customers
SET score = 0
WHERE id = 6

-- Change the score of the customer with ID 10 to 0 and update the country to 'UK'
UPDATE customers
SET 
    score = 0,
    country = 'UK'
WHERE id = 10

--Update all customers with NULL score by setting their scores to 0
UPDATE customers
SET score = 0
WHERE score IS NULL

/* UPDATE. It is used to manipulate an actual value in a table. 
   The WHERE clause is used along with it to select the actual data point so as to avoid error.*/


-- DELETE
-- Delete all customers with an ID greater than 5

DELETE FROM customers
WHERE id > 5

SELECT * FROM customers

-- Delete all data from the table persons
DELETE FROM persons;

-- TRUNCATE TABLE persons

/* DELETE is used to delete specific or all records in a table. If it is all records, 
TRUNCATE is more advisable to be used especially when it involves  a large table.*/

SELECT * FROM persons


