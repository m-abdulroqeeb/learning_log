/*
-------------------------------------------------
Data Definition Language(DDL)
-------------------------------------------------
The DDL includes:
   1. CREATE - Creating Tables
   2. ALTER - Modifying Table Structure
   3. DROP - Removing Tables
*/

-- CREATE
-- Create a new table called persons with columns:id,person_name,birth_date,and phone
CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	Phone VARCHAR(50) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
);
/* CREATE TABLE is used to create a table in a database.
Along with a well defined data type of columns.*/

-- ALTER
-- Add a new column called email to the persons table
ALTER TABLE persons 
ADD email VARCHAR(50); NOT NULL

-- Remove the column phone from the persons table
ALTER TABLE persons
DROP COLUMN phone;

/*To edit an already created table, 
  such as adding or dropping a column,
  we use ALTER TABLE.
  */

-- DROP
-- Delete the table persons from the database
DROP TABLE persons;

/*DROP TABLE permanently deletes the entire table — 
  both its structure and all the data in it. 
  This is different from deleting rows (DELETE) — 
  DROP removes the table itself, not just its contents.*/