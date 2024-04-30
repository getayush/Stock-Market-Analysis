-- Subquery (You can find the days when the closing price was above the average price)
SELECT *
FROM Stocks
WHERE [Close] > (SELECT AVG([Close]) FROM Stocks)

SELECT * 
FROM Stocks
WHERE DATEPART(year, Date) > 2015 
AND [Close] > (SELECT AVG([Close]) FROM Stocks WHERE DATEPART(year, Date) > 2015)

-- Window ( Calculate the cumulative volume over time )
SELECT Date,
       Volume,
       SUM(CAST(Volume AS decimal(18,2))) OVER (ORDER BY Date) as CumulativeVolume
FROM Stocks
WHERE DATEPART(year, Date) > 2005

 -- Order By and Group BY ( Find the days with exceptionally high trading volumes )
SELECT Date, SUM(Volume) as TotalVolume
FROM Stocks
WHERE DATEPART(year, Date) > 2010
GROUP BY Date
HAVING SUM(CAST(Volume AS decimal(18,2))) > (SELECT AVG(CAST(Volume AS decimal(18,2))) * 1.5 FROM Stocks)

-- Write a query to find the average closing price (Close) for each year.
SELECT DATEPART(year, Date) AS Years, avg([Close]) AS AvgClosingPrice 
 FROM Stocks
GROUP BY DATEPART(year, Date) 

-- Retrieve a list of dates where the closing price was higher than the opening price, 
-- ordered by the difference between the closing and opening prices in descending order.
SELECT [Date] AS ListofDates
 FROM Stocks
 WHERE [Close] > [Open]
ORDER BY ([Close] - [Open]) DESC

-- Write a subquery to find the date with the highest volume, and then retrieve all the columns for that date.
SELECT *
  FROM Stocks
WHERE Volume = (SELECT MAX(Volume) FROM Stocks)

-- Calculate the running total of Volume over time using a window function.
SELECT *, 
  SUM(CAST(Volume AS DECIMAL(18,2))) OVER (ORDER BY Date ASC) AS RunningTotal 
FROM Stocks 

-- Subquery for Filtering Based on Trend Conditions:
SELECT * FROM Stocks
WHERE [Close] > (SELECT AVG([Close]) FROM Stocks WHERE Date BETWEEN DateAdd(year, -1, Stocks.Date) AND Stocks.Date)
AND Date >= '2015-01-01'

-- Group data by year to see how the returns distribution changes annually.
SELECT 
    YEAR(Date) as Year,
    AVG(Daily_Return) as AvgReturn,
    MAX(Daily_Return) as MaxReturn,
    MIN(Daily_Return) as MinReturn
FROM Stocks
GROUP BY YEAR(Date)
HAVING AVG(Daily_Return) > 0;

-- Window Function (LAG(), LEAD(), ROW_NUMBER() to find Closing Price for Previous and Next days)
SELECT Date, 
       [Close], 
       LAG([Close], 1) OVER (ORDER BY Date) AS Previous_Day_Close 
FROM Stocks

SELECT Date, 
       [Close], 
       LEAD([Close], 1) OVER (ORDER BY Date) AS Next_Day_Close 
FROM Stocks

SELECT Date, 
       [Close], 
       ROW_NUMBER() OVER (PARTITION BY [Open] ORDER BY Date) AS RowNum 
FROM Stocks