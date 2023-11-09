-- 000000
-- CREATING DATA MARTS
-- 000000

-- Use the correct schema
USE adventure_works_2022;

-- 000
-- DATA MART 1 - Product Performance
-- 000
-- Description: Analyze product performance metrics such as total revenue, profit, and profit margin.
-- 000

-- Drop the ProductPerformance view if it exists
DROP VIEW IF EXISTS ProductPerformance;

-- Create a new view called ProductPerformance
CREATE VIEW ProductPerformance AS
SELECT
    ProductKey,
    Product,
    Subcategory,
    Category,
    SUM(Quantity) AS TotalQuantity,
    ROUND(SUM(Sales)) AS TotalRevenue,
    ROUND(SUM(Sales - Cost)) AS TotalProfit,
    ROUND((SUM(Sales - Cost) / NULLIF(SUM(Sales), 0)) * 100, 2) AS ProfitMargin
-- Select data from the analytical_layer table
FROM analytical_store
-- Group the data by these columns
GROUP BY ProductKey, Product, Subcategory, Category
-- Order the results by ProfitMargin in descending order
ORDER BY ProfitMargin DESC;

-- Retrieve and display data from the ProductPerformance view
select * from productperformance;

-- 000
-- DATA MART 2 - Sales By Region
-- 000
-- Description: Examine various sales patterns across regions such as number of reseller, total revenue and quantity sold.
-- 000

-- Drop the SalesByRegion view if it exists
DROP VIEW IF EXISTS SalesByRegion;

-- Create a new view called SalesByRegion
CREATE VIEW SalesByRegion AS
SELECT
    SalesTerritoryKey,
    Region,
    Country,
    TerritoryGroup,
    COUNT(DISTINCT ResellerKey) AS ResellerCount,
    ROUND(SUM(Sales)) AS TotalRevenue,
    SUM(Quantity) AS TotalQuantity
-- Select data from the analytical_layer table
FROM analytical_store
-- Group the data by these columns
GROUP BY SalesTerritoryKey, Region, Country, TerritoryGroup
-- Order the results by TotalRevenue in descending order
ORDER BY TotalRevenue DESC;

-- Retrieve and display data from the SalesByRegion view
select * from SalesByRegion;

-- 000
-- DATA MART 3 - Reseller Performance
-- 000
-- Description:  Assess the performance of resellers and supply various metrics such as their state or origin, revenue and quantity sold.
-- 000

-- Drop the ResellerPerformance view if it exists
DROP VIEW IF EXISTS ResellerPerformance;

-- Create a new view called ResellerPerformance
CREATE VIEW ResellerPerformance AS
SELECT
    ResellerKey,
    ResellerName,
    ResellerBusinessType,
    ResellerCity,
    ResellerState,
    ResellerCountry,
    ROUND(SUM(Sales)) AS TotalRevenue,
    SUM(Quantity) AS TotalQuantity
-- Select data from the analytical_layer table
FROM analytical_store
-- Group the data by these columns
GROUP BY ResellerKey, ResellerName, ResellerBusinessType, ResellerCity, ResellerState, ResellerCountry
-- Order the results by TotalRevenue in descending order
ORDER BY TotalRevenue DESC;

-- Retrieve and display data from the ResellerPerformance view
select * from ResellerPerformance;

-- 000
-- DATA MART 4 - SalesPersonPerformance
-- 000
-- Description: Evaluate salesperson performance (sum of sales) by region and country.
-- 000

-- Drop the SalesPersonPerformance view if it exists
DROP VIEW IF EXISTS SalesPersonPerformance;

-- Create a new view called ResellerPerformance
CREATE VIEW SalesPersonPerformance AS
SELECT
    Salesperson,
    Region,
    Country,
    ROUND(SUM(Sales)) AS Performance
-- Select data from the analytical_layer table
FROM analytical_store
-- Group the data by these columns
GROUP BY Salesperson, Region, Country
-- Order the results by Performance in descending order
ORDER BY Performance DESC;

-- Retrieve and display data from the SalesPersonPerformance view
select * from SalesPersonPerformance;

