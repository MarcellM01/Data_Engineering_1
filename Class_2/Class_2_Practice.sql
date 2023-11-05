use classicmodels;

-- E1

DROP PROCEDURE IF EXISTS GetAllProducts;

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT *  FROM products;
END //

DELIMITER ;

CALL GetAllProducts();

-- E2

DROP PROCEDURE IF EXISTS GetOfficeByCountry;

DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN countryName VARCHAR(255)
)
BEGIN
	SELECT * 
 		FROM offices
			WHERE country = countryName;
END //
DELIMITER ;

-- Question 1

DROP PROCEDURE IF EXISTS FirstEntries;

DELIMITER //

CREATE PROCEDURE FirstEntries(
	IN entries INT
)
BEGIN
	SELECT * FROM payments limit entries;
END //
DELIMITER ;

call FirstEntries(5);

-- E3

DROP PROCEDURE IF EXISTS GetOrderCountByStatus;

DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber) INTO total FROM orders WHERE status = orderStatus;
END$$
DELIMITER ;

CALL GetOrderCountByStatus('Shipped',@total);
SELECT @total;

-- Question 2

DROP PROCEDURE IF EXISTS GetAmount;

DELIMITER $$

CREATE PROCEDURE GetAmount (
	IN entry INT,
	OUT cost double
)
BEGIN
	SET entry = entry - 1;
	SELECT amount into cost FROM payments limit entry,1 ;
END$$
DELIMITER ;

CALL GetAmount(1,@total);
SELECT @total;

-- E4

DROP PROCEDURE IF EXISTS GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    	IN  pCustomerNumber INT, 
    	OUT pCustomerLevel  VARCHAR(20)
)
BEGIN
	DECLARE credit DECIMAL DEFAULT 0;

	SELECT creditLimit 
		INTO credit
			FROM customers
				WHERE customerNumber = pCustomerNumber;

	IF credit > 50000 THEN
		SET pCustomerLevel = 'PLATINUM';
	ELSE
		SET pCustomerLevel = 'NOT PLATINUM';
	END IF;
END$$
DELIMITER ;

CALL GetCustomerLevel(447, @level);
SELECT @level;

-- Question 3




