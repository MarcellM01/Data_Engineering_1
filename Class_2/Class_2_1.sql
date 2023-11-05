select * from products inner join productlines on products.productline = productlines.productline;

-- aliasing

select * from products as t1 inner join productlines as t2 on t1.productline = t2.productline;

-- using

select * from products inner join productlines using(productline);

-- specific columns

select t1.productName, t1.productLine, t2.textDescription
from products t1
inner join productlines t2
on t1.productline = t2.productline;

-- Question 1

select * from orders inner join orderdetails using(orderNumber);

-- Question 2

-- Join all fields of order and orderdetails. Display only orderNumber, 
-- status and sum of totalsales (quantityOrdered * priceEach) for each orderNumber.

select t1.orderNumber, t1.status, sum(t2.quantityOrdered * t2.priceEach) as totalsales
from orders t1
inner join orderdetails t2
using(orderNumber)
group by t1.orderNumber, t1.status;

-- Question 3
-- We want to know how the employees are performing. Join orders, customers and employees and return orderDate,lastName, firstName

select
	t1.orderDate,
    t3.lastName,
    t3.firstName
from orders t1
inner join customers t2
using (customerNumber)
inner join employees t3
on t2.salesRepEmployeeNumber = t3.employeeNumber;

SELECT
	count(*),
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
    customers c
inner JOIN orders o 
    ON c.customerNumber = o.customerNumber;

-- Creates whole join and then filters

SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
INNER JOIN orderDetails 
    USING (orderNumber)
WHERE
    orderNumber = 10123;

-- Creates a filtered table directly

SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
INNER JOIN orderDetails d 
    ON o.orderNumber = d.orderNumber AND 
       o.orderNumber = 10123;

