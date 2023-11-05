Use birdstrikes;

-- CREATE TABLE birdstrikes_oklahoma LIKE birdstrikes;

DROP TABLE birdstrikes_oklahoma;

CREATE TABLE birdstrikes_oklahoma AS SELECT * FROM birdstrikes where state = 'Oklahoma';

-- This is an ETL pipeline

Use classicmodels;

DROP PROCEDURE IF EXISTS CreateProductSalesStore;

DELIMITER //

CREATE PROCEDURE CreateProductSalesStore()
BEGIN

	DROP TABLE IF EXISTS product_sales;

	CREATE TABLE product_sales AS
	SELECT 
	   orders.orderNumber AS SalesId, 
	   orderdetails.priceEach AS Price, 
	   orderdetails.quantityOrdered AS Unit,
	   products.productName AS Product,
	   products.productLine As Brand,   
	   customers.city As City,
	   customers.country As Country,   
	   orders.orderDate AS Date,
	   WEEK(orders.orderDate) as WeekOfYear
	FROM
		orders
	INNER JOIN
		orderdetails USING (orderNumber)
	INNER JOIN
		products USING (productCode)
	INNER JOIN
		customers USING (customerNumber)
	ORDER BY 
		orderNumber, 
		orderLineNumber;

END //
DELIMITER ;


CALL CreateProductSalesStore();

-- Scheduling pipeline needs to run in specified intervals, this code below create a message every second for one hour and
-- writes it to the "messages" table.

SET GLOBAL event_scheduler = OFF;

drop table messages;
create table if not exists messages (message varchar(100) not null);
truncate messages;

DROP event IF EXISTS add_message_every_second;
DELIMITER $$

CREATE EVENT add_message_every_second
ON SCHEDULE EVERY 1 second
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
	BEGIN
		INSERT INTO messages SELECT CONCAT(NOW());
	END$$
DELIMITER ;

SHOW VARIABLES LIKE "event_scheduler";
SET GLOBAL event_scheduler = ON;

select * from messages;

show events;

-- Triggers, triggering something based on an event.alter (this is for an extra point)

DROP TRIGGER IF EXISTS after_order_insert; 

DELIMITER $$

CREATE TRIGGER after_order_insert
AFTER INSERT
ON orderdetails FOR EACH ROW
BEGIN
	
	-- log the order number of the newley inserted order
    	INSERT INTO messages SELECT CONCAT('new orderNumber: ', NEW.orderNumber);

	-- archive the order and assosiated table entries to product_sales
    -- This line below is literally the trigger
  	INSERT INTO product_sales
	SELECT 
	   orders.orderNumber AS SalesId, 
	   orderdetails.priceEach AS Price, 
	   orderdetails.quantityOrdered AS Unit,
	   products.productName AS Product,
	   products.productLine As Brand,
	   customers.city As City,
	   customers.country As Country,   
	   orders.orderDate AS Date,
	   WEEK(orders.orderDate) as WeekOfYear
	FROM
		orders
	INNER JOIN
		orderdetails USING (orderNumber)
	INNER JOIN
		products USING (productCode)
	INNER JOIN
		customers USING (customerNumber)
	WHERE orderNumber = NEW.orderNumber
	ORDER BY 
		orderNumber, 
		orderLineNumber;
        
END $$

DELIMITER ;

SELECT * FROM product_sales ORDER BY SalesId;

INSERT INTO orders  VALUES(16,'2020-10-01','2020-10-01','2020-10-01','Done','',131);
INSERT INTO orderdetails  VALUES(16,'S18_1749','1','10',1);

INSERT INTO orders  VALUES(18,'2020-10-01','2020-10-01','2020-10-01','Done','',131);
INSERT INTO orderdetails  VALUES(18,'S18_1749','1','10',1);

SELECT * FROM product_sales ORDER BY SalesId;

-- Data Marts (materilaized view for an extra point)

DROP VIEW IF EXISTS Vintage_Cars;

CREATE VIEW `Vintage_Cars` AS
SELECT * FROM product_sales WHERE product_sales.Brand = 'Vintage Cars';

select * from classicmodels.vintage_cars;

DROP VIEW IF EXISTS USA;

CREATE VIEW `USA` AS
SELECT * FROM product_sales WHERE country = 'USA';

select * from classicmodels.usa;

-- Question 4

CREATE VIEW `Prod_S_2003_2005` AS
SELECT * FROM product_sales WHERE product_sales.Date >= 2003;
SELECT * FROM product_sales WHERE product_sales.Date <= 2005;

select date from classicmodels.Prod_S_2003_2005;



