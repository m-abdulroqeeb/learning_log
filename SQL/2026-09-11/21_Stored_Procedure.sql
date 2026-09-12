/* ---------------------------------------------------------
					STORED PROCEDURE
   ---------------------------------------------------------
	What is a Stored Procedure?
	A saved, reusable block of SQL code that can accept inputs (parameters),
	perform logic, and return results — created once, executed many times.

	Basics:
	* Parameters: Placeholders used to pass values as input from the caller to the procedure,
	  allowing the same procedure to process different data dynamically.
	* Variables: Placeholders used to store values for later use within the procedure.
	  Declaring a variable has three steps:
		1. Declare the variable
		2. Assign a value to it
		3. Use the variable

	Anything the PRINT function outputs must be a string — non-string values 
	(like INT or FLOAT) must be explicitly cast to avoid errors.

	Control Flow:
	* IF/ELSE: Runs different logic depending on whether a condition is true or false.

	Error Handling:
	* TRY/CATCH: Code inside TRY runs normally; if it fails, control passes to CATCH,
	  where the error can be caught and reported instead of crashing the script.
	  Useful functions inside CATCH: ERROR_MESSAGE(), ERROR_NUMBER(), ERROR_LINE(), ERROR_PROCEDURE().
*/
-- STEP 1: Write a query for US customers, find the total number of customers and the average score

SELECT 
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM  Sales.Customers
WHERE Country = 'USA'

-- STEP 2: Turning the query into a stored procedure

-- For Germany, find the total number of customers and average
CREATE OR ALTER PROCEDURE GetCustomerSummaryGermany AS
BEGIN
SELECT 
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM  Sales.Customers
WHERE Country = 'Germany'
END;

EXEC GetCustomerSummaryGermany

-- STEP 3: Define the parameter
-- ALTER PROCEDURE  GetCustomerSummary @Country NVARCHAR(50) AS
-- Define USA as default
CREATE OR ALTER PROCEDURE  GetCustomerSummary @Country NVARCHAR(50) =	'USA' AS
BEGIN
	BEGIN TRY
		DECLARE @TotalCustomers INT, @AvgScore FLOAT;

		-- ==================================================
		-- Prepare and clean up
		-- =================================================
		IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
		BEGIN
			PRINT ('Updating NULL Scores to 0');
			UPDATE Sales.Customers
			SET Score = 0
			WHERE Score IS NULL AND Country = @Country;
		END

		ELSE
		BEGIN
			PRINT 'No NULL Scores found';
		END;

		-- ===================================================
		-- Generating Reports
		-- ===================================================
		-- Calculate the total customers and average score for a specific country
		SELECT 
			@TotalCustomers =  COUNT(*),
			@AvgScore = AVG(Score) 
		FROM  Sales.Customers
		WHERE Country = @Country;

		PRINT 'Total Customers from ' + @Country + ':' + CAST( @TotalCustomers AS NVARCHAR);
		PRINT 'Average Score from '+  @Country + ':' + CAST(@AvgScore AS NVARCHAR);

		-- Calculate total number of orders and total sales for a specific country
		SELECT 
			COUNT(*) NrOfOrders,
			SUM(Sales) TotalSales
		FROM Sales.Orders o
		JOIN Sales.Customers c
		ON c.CustomerID = o.CustomerID
		WHERE c. Country = @Country
	END TRY
	BEGIN CATCH
		--========================================
		--Error Handling
		--========================================
		PRINT('An error occurred.');
		PRINT('An error message: ' + ERROR_MESSAGE());
		PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('Error Procedure: ' + ERROR_PROCEDURE())
	END CATCH 

END;
GO

-- Execute the stored procedure
EXEC GetCustomerSummary @Country = 'Germany'
EXEC GetCustomerSummary @Country = 'USA'
EXEC GetCustomerSummary;