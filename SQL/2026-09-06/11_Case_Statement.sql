/*-----------------------------------------------------------------
	CASE STATEMENT
  -----------------------------------------------------------------
  Evaluates a list of conditions and returns a value when the condition is met. 
  SQL stops execution once the first condition is met. It must be pointed out that it
  can be used in all SQL clauses.

	Use Cases:
		* Data transformation
		* Data Categorization
		* Mapping values
		* Handling Nulls
		* Conditional Aggregation

	Rule
	The data type of the output must match. That is to say it must be the same.
  */

-- Data Categorisation
/* Generate a report showing the total sales for each category:
-- High: If the sales higher than 50
-- Medium: if the sales is between 20 and 50
-- Low: if the sales is 20 or less
-- Sort the result from the highest to the lowest */

SELECT
	Category,
	SUM(Sales) AS TotalSales
FROM 
(
SELECT 
	OrderID,
	Sales,
	CASE
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN  'Medium'
		ELSE 'Low'
	END Category
FROM Sales.Orders
) t
GROUP BY Category
ORDER BY SUM(Sales) DESC

-- Data Mapping
-- Retrieve employee details with gender displayed as full text
SELECT 
	EmployeeID,
	FirstName,
	LastName,
	Gender,
	CASE
		WHEN Gender = 'M' THEN 'Male'
		WHEN Gender = 'F' THEN 'Female'
		ELSE 'Not Available'
	END GenderFullText
FROM Sales.Employees

-- Retrieve customer details with abbreviated country code
SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE 
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA' THEN 'US'
		ELSE 'n/a'
	END CountryAbbr,
	--Quick Form
		CASE Country
		WHEN 'Germany' THEN 'DE'
		WHEN 'USA' THEN 'US'
		ELSE 'n/a'
	END CountryAbbrQuickForm
FROM Sales.Customers

-- Handling Nulls
/* Find the average scores of customers and treat Nulls as 0
   And additionally provide details such as CustomerID & LastName */
SELECT 
	CustomerID,
	LastName,
	Score,
	CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END ScoreClean,
	AVG(CASE
			WHEN Score IS NULL THEN 0
		    ELSE Score
	     END) OVER() AvgScoreClean,
	AVG(score) OVER() AvgCustomer
FROM Sales.Customers

-- Conditional Aggregation
-- Count how many times each customer has made an order with sales greater than 30
SELECT
	CustomerID,
	SUM(CASE 
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) AS HighValueOrders,
	COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

