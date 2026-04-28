--SQL Practice Queries
--Author: Preksha

--Task 1: Customers with Only One Order
--Find customers who have placed exactly one order.

SELECT CustomerID, COUNT(*) AS NumberOfOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) = 1;
	

--Task 2: Customers with Above Average Orders
--Find customers who have placed more orders than the average number of orders per customer.

SELECT CustomerID, COUNT(*) AS NumberOfOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >
					(SELECT AVG(NumberOfOrders)
					FROM (SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders
							FROM Orders 
							GROUP BY CustomerID) t
					);


--Task 3: Customers with More Than 10 Orders
--Identify customers who have placed more than 10 orders.

SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 10;

-- Task 4: Customers Who Ordered in Every Year
-- Find customers who have placed orders in every year present in the dataset.

SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT YEAR(OrderDate)) = (SELECT COUNT(DISTINCT Year(OrderDate))
											FROM Orders);


--Task 5: Monthly and Yearly Order Trend
-- Analyze number of orders placed per month and year.

SELECT MONTH(OrderDate) AS MonthNumber, YEAR(OrderDate) AS YearNumber, DateName(Month, OrderDate), COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY MONTH(OrderDate), YEAR(OrderDate), DateName(Month, OrderDate) 
Order BY MonthNumber, YearNumber



