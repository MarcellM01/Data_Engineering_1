use classicmodels;
select
	t1.city,
    t1.country,
    t2.orderNumber,
    t2.orderDate,
    t3.priceEach,
    t3.quantityOrdered,
    t4.productName,
    t4.productLine
from customers t1
inner join orders t2
using (customerNumber)
inner join orderdetails t3
using (orderNumber)
inner join products t4
using (productCode);