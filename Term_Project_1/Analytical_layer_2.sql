-- 000000
-- CREATING THE ANALYTICAL LAYER
-- 000000

-- Use the correct schema
USE adventure_works_2022;

-- Create procedure for generating the analytical data store
DROP PROCEDURE IF EXISTS CreateAnalyticalStore;

DELIMITER //

CREATE PROCEDURE CreateAnalyticalStore()
BEGIN
-- Drop the analytical_store table if it exists to start fresh
DROP TABLE IF EXISTS analytical_store;
-- Create a new table called analytical_store
CREATE TABLE analytical_store AS
SELECT
    s.SalesOrderNumber,
    s.OrderDate,
    s.Quantity,
    s.UnitPrice,
    s.Sales,
    s.Cost,
    p.StandardCost,
    p.Subcategory,
    p.Category,
    p.ProductKey,
    p.Product,
    rp.ResellerKey AS ResellerKey,
    rp.BusinessType AS ResellerBusinessType,
    rp.Reseller AS ResellerName,
    rp.City AS ResellerCity,
    rp.StateProvince AS ResellerState,
    rp.CountryRegion AS ResellerCountry,
	sp.Salesperson,
    r.SalesTerritoryKey AS SalesTerritoryKey,
    r.Region,
    r.Country,
    r.Group AS TerritoryGroup

-- Select data from the sales_shortened table and alias it as "s"
FROM sales_shortened AS s

-- Perform an inner join with the product table on ProductKey aliased as "p"
INNER JOIN product AS p ON s.ProductKey = p.ProductKey

-- Perform an inner join with the reseller table on ResellerKey aliased as "rp"
INNER JOIN reseller AS rp ON s.ResellerKey = rp.ResellerKey

-- Perform an inner join with the salesperson table on EmployeeKey aliased as "sp"
INNER JOIN salesperson AS sp ON s.EmployeeKey = sp.EmployeeKey

-- Perform an inner join with the salespersonregion table on EmployeeKey aliased as "spr"
INNER JOIN salespersonregion AS spr ON sp.EmployeeKey = spr.EmployeeKey

-- Perform an inner join with the region table on SalesTerritoryKey aliased as "r"
INNER JOIN region AS r ON spr.SalesTerritoryKey = r.SalesTerritoryKey;

END //
DELIMITER ;

-- Check method and generate the analytical_store table                            
CALL CreateAnalyticalStore();

-- Check validity of analytical_store
select * from analytical_store;


-- 000
-- TEST
-- 000

-- The original sales_shortened table had 717 observations, the analytical layer has the same number, thus the code ran correctly
SELECT count(*) FROM analytical_store; -- 717 observations
SELECT count(*) FROM sales_shortened; -- 717 observations

-- 000000
-- CREATING THE ETL PIPELINE
-- 000000

-- Create messages table
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (message varchar(255) NOT NULL);

-- Create InsertNewSale procedure to be used for recording new transactions
DROP PROCEDURE IF EXISTS InsertNewSaleProc;

DELIMITER //

CREATE PROCEDURE InsertNewSaleProc(
    IN newSalesOrderNumber text,
    IN newOrderDate double,
    IN newProductKey double,
    IN newResellerKey double,
    IN newEmployeeKey double,
    IN newSalesTerritoryKey double,
    IN newQuantity double,
    IN newUnitPrice double,
    IN newSales double,
    IN newCost double
)
BEGIN
-- Create a message with the "SalesOrderNumber" to record evidence of transaction
    INSERT INTO messages SELECT CONCAT('new SalesOrderNumber: ', newSalesOrderNumber);

-- Insert values provided by the user into the "sales_shortened" table
    INSERT INTO `Sales_shortened` (SalesOrderNumber, OrderDate, ProductKey, ResellerKey, EmployeeKey, SalesTerritoryKey, Quantity, UnitPrice, Sales, Cost)
    VALUES (newSalesOrderNumber, newOrderDate, newProductKey, newResellerKey, newEmployeeKey, newSalesTerritoryKey, newQuantity, newUnitPrice, newSales, newCost);
END //

DELIMITER ;

-- To insert data, you can call the 'InsertNewSaleProc' procedure, sample data with call provided below
CALL InsertNewSaleProc('SO12345', 44000, 453, 475, 282, 4, 5, 29.99, 299.90, 149.95);

-- To update the analytics_store with the new data call the 'CreateAnalyticalStore()' procedure.
CALL CreateAnalyticalStore();

-- 000
-- TESTING
-- 000

-- Check the messages and Sales_shortened tables
SELECT * FROM messages; -- See if the transaction is displayed
SELECT count(*) FROM `Sales_shortened`; -- See if the number of values has increased, default is 717

-- Check to see if the number records in the analytical layer has increased, default is 717
select count(*) from analytical_store;


