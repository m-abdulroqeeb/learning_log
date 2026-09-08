/*-------------------------------------------------------------
		WINDOW RANKING FUNCTION
---------------------------------------------------------------*/
-- ROW_NUMBER()
-- Rank the orders based on their sales from the highest to the lowest
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row
FROM Sales.Orders

/* ROW_NUMBER(): Assigns a unique number to each row. It doesn't handle ties.
	Use cases:
 - Top-N Analysis
 - Bottom-N Analysis
 - Assign unique IDs
 - Identifying duplicates
*/

-- RANK()
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row,
	-- Using rank function
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank
FROM Sales.Orders
/* RANK(): Assigns a rank to each row and handles ties...It leaves gaps in ranking */


-- DENSE_RANK()
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row,
	-- Using rank function
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
	-- Using Dense_Rank
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Dense
FROM Sales.Orders
/* DENSE_RANK(): Assigns a rank to each row. It handles ties. It doesn't leave gaps.*/

-- Top-N Analysis
-- Find the top highest sales for each product
SELECT * 
FROM(
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER( PARTITION BY ProductID ORDER BY Sales DESC) AS RankByProduct
FROM Sales.Orders
)t
WHERE RankByProduct = 1

-- Bottom-N Analysis
-- Find the lowest customers based on their total sales
SELECT * FROM(
SELECT 
	CustomerID,
	SUM(Sales) AS TotalSales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) AS RankCustomers
FROM Sales.Orders 
GROUP BY CustomerID
)t
-- WHERE RankCustomers IN (1,2)
WHERE RankCustomers <= 2

-- Generating unique ID
-- Assign unique IDs to the rows of the 'Orders Archive' Table
SELECT 
	ROW_NUMBER() OVER( ORDER BY OrderID) AS UniqueID,
	* 
FROM Sales.OrdersArchive

-- Identify_Duplicate
-- Identify duplicate rows in the table 'Orders Archive' and return a clean result without any duplicates
SELECT * FROM(
SELECT 
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn,
* FROM Sales.OrdersArchive
)t 
WHERE rn = 1

--NTILE():
SELECT 
	OrderID,
	Sales,
	NTILE(1) OVER(ORDER BY Sales DESC) OneBucket,
	NTILE(2) OVER(ORDER BY Sales DESC) TwoBuckets,
	NTILE(3) OVER(ORDER BY Sales DESC) ThreeBuckets,
	NTILE(4) OVER(ORDER BY Sales DESC) FourBuckets
FROM Sales.Orders
/* NTILE(): Divides the rows into a specified number of approximately equal groups (buckets). 
   Bucket Size = Number of rows / Number of Buckets. If we don't have perfectly sized buckets,
   the larger group comes first. 
	 USE CASES:
  - Data Segmentation
  - Equalizing Load processing
*/

-- Segment all orders into 3 categories: high, medium, low sales
SELECT  
	OrderID, 
	Sales,
	CASE ThreeBuckets
		WHEN 1 THEN 'High'
		WHEN 2 THEN 'Medium'
		WHEN 3 THEN 'Low'
	END SalesSegmentation
FROM(
SELECT 
	OrderID,
	ProductID,
	Sales,
	NTILE(3) OVER( ORDER BY Sales Desc) AS ThreeBuckets
FROM Sales.Orders
)t

-- In order to export the data, divide the orders into two groups
SELECT  
	NTILE(2) OVER(ORDER BY OrderID ASC) AS Buckets,
	*
FROM Sales.Orders

-- CUME_DIST()
-- Find the products that fall within the highest 40% of the prices
SELECT 
*,
CONCAT(DistRankC * 100, '%') DistRankCPercentage,
CONCAT(DistRankP * 100, '%') DistRankPPercentage
FROM(
SELECT 
	Product,
	Price,
	-- Percent_Rank
	PERCENT_RANK() OVER(ORDER BY Price DESC) AS DistRankP,
	-- Cume_Dist
	CUME_DIST() OVER(ORDER BY Price DESC) AS DistRankC
FROM Sales.Products
)t
WHERE DistRankC <= 0.4
/* CUME_DIST():  
   Cumulative Distribution: the position of your data point within the distribution of the window. 
   Formula = Position Nr / Number of Rows
   PERCENT_RANK():
   (Position Nr - 1) / (Number of Rows - 1). 
   Calculates the relative position of each row within a window. 
*/