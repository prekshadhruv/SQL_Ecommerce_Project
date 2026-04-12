-- Project: E-commerce Sales Analysis (Northwind)
-- Author: Preksha

-----------------------------------------
-- Task 1: Monthly Revenue Trend Analysis

SELECT 
    YEAR(O.OrderDate) AS OrderYear,
    MONTH(O.OrderDate) AS OrderMonthNumber,   
    DATENAME(Month, O.OrderDate) AS OrderMonthName, 
    SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS Revenue
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate), DATENAME(Month, O.OrderDate)
ORDER BY OrderYear, OrderMonthNumber;

GO

-- Task 2: Top 5 Customers by Total Sales

SELECT TOP 5 
    c.CompanyName, 
    SUM(OD.UnitPrice * OD.Quantity) AS TotalSales
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] OD ON o.OrderID = OD.OrderID
GROUP BY c.CompanyName
ORDER BY TotalSales DESC;

GO

-- Task 3: Customers with No Orders

SELECT c.CompanyName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

GO

-- Task 4: Shipping Performance Analysis

SELECT 
    S.ShipperID, 
    S.CompanyName, 
    COUNT(O.OrderID) AS TotalOrdersShipped
FROM Shippers S
JOIN Orders O ON S.ShipperID = O.ShipVia
GROUP BY S.ShipperID, S.CompanyName
ORDER BY TotalOrdersShipped DESC;

GO

-- Task 5: Country-wise Sales and Revenue Analysis

SELECT 
    C.Country, 
    SUM(OD.UnitPrice * OD.Quantity) AS TotalSales, 
    SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Revenue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.Country
ORDER BY Revenue DESC;

GO

-- Task 6: Customer Total Spending Analysis

SELECT 
    C.CustomerID, 
    C.CompanyName,
    SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalSpending
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY TotalSpending DESC;

GO

-- Task 7: Year-wise Revenue Analysis

SELECT 
    YEAR(O.OrderDate) AS OrderYear, 
    SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS Revenue
FROM Orders O 
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate)
ORDER BY Revenue DESC;