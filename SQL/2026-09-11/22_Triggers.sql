/*--------------------------------------------------------
							TRIGGERS
 ----------------------------------------------------------
	What is a Trigger?
	A special stored procedure (set of statements) that automatically runs 
	in response to a specific event on a table or view — you don't call it 
	directly, SQL Server fires it automatically when the event happens.

	Trigger Types:
	* DML triggers: Fire in response to INSERT, UPDATE, or DELETE
		- AFTER: Runs after the triggering action has already happened
		- INSTEAD OF: Runs in place of the triggering action, the original 
		  action never actually happens on the base table; the trigger's 
		  logic replaces it entirely
	* DDL triggers: Fire in response to schema changes (e.g. CREATE, ALTER, DROP)
	* LOGON triggers: Fire in response to a user logging into the SQL Server instance

	Use Cases:
	* Auditing / logging changes automatically (as demonstrated below)
	* Enforcing business rules that a simple constraint can't express
	* Automatically keeping related tables in sync
*/
CREATE TABLE Sales.EmployeeLogs(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE)

	
CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS
BEGIN
	INSERT INTO Sales.EmployeeLogs(EmployeeID,LogMessage,LogDate)
	SELECT 
		EmployeeID,
		'New Employee Added ='  + CAST(EmployeeID AS VARCHAR),
		GETDATE() 
	FROM INSERTED 
END
/* INSERTED: A virtual table that holds a copy of the rows that are 
   being inserted into the target table.
   (Its counterpart, DELETED, holds a copy of rows being removed 
   or the "before" version of updated rows.) */
SELECT * FROM Sales.EmployeeLogs

SELECT * FROM Sales.Employees
INSERT INTO Sales.Employees
VALUES
(6,'Maria','Doe','HR','1988-01-12','F',8000,3)

SELECT * FROM Sales.Customers