/*
===========================================================================
					CREATE DATABASE AND SCHEMAS
===========================================================================
Script Purpose:
	Creates a new database named 'DataWarehouse' after checking if it 
	already exists, and if so, dropping it first. The script then sets up 
	three schemas within the database: 'bronze', 'silver', and 'gold' — 
	representing the three layers of a medallion architecture 
	(raw data, cleaned/transformed data, and business-ready data).

Warning:
	Running this script will completely drop the existing 'DataWarehouse' 
	database if it already exists. All data in that database will be 
	permanently deleted. Proceed with caution and ensure proper backups 
	exist before running.
*/

USE master;
GO

-- Drop and recreate 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO