Use classicmodels;
# 1.	Use the customers table to find total customers in each state
SELECT state, count(customerNumber) AS 'Number of Customers' from customers WHERE state IS NOT NULL group by state ;

# a.	Find customers in each city
SELECT  city, count(customerNumber) AS 'Number of Customers' from customers WHERE city IS NOT NULL 
GROUP BY city ;
# b.	Find the number of customers in USA, Germany and France
SELECT   country,count(customerNumber) AS 'Number of Customers'  
FROM customers
WHERE country in ('France','USA','Germany')
group by country;

#2.	Find the customers for whom at least one order was cancelled ?
SELECT customerName 
FROM customers 
WHERE customerNumber IN (SELECT customerNumber FROM orders WHERE status='Cancelled');

#3.	Use customer table and find customers with credit limit greater than 500000. How many customers beyond this limit range are in city if San Francisco?
SELECT customerName FROM customers WHERE creditLimit>500000;
SELECT count(customernumber) FROM customers WHERE creditLimit>500000 AND city='San Francisco';


#4.	Join customer and employees table and find number of employees with job title Sales Rep
SELECT count(employees.employeeNumber) 
FROM customers JOIN employees ON employees.employeeNumber=customers.salesRepEmployeeNumber WHERE employees.jobTitle='Sales Rep';

#5.	a) Join customer, orderdetails and orders table to find number of orders with price >100. 
#b)	How many such customers were there in each state

#5a)	
SELECT count(od.orderNumber) as 'Order Count'
FROM customers c JOIN orders o ON c.customerNumber=o.customerNumber JOIN orderdetails od ON od.orderNumber=o.orderNumber
WHERE od.priceEach>100;
#5b) 
SELECT c.state,count(c.customerNumber) AS 'Customer Count'
FROM customers c JOIN orders o ON c.customerNumber=o.customerNumber JOIN orderdetails od ON od.orderNumber=o.orderNumber
WHERE od.priceEach>100 AND c.state IS NOT NULL
GROUP BY c.state;

#6.	Now use customer and payments table and find the payments that were made across each state in total. Which state had the highest total amount?

SELECT c.state,sum(p.amount) AS 'Total Payment'
FROM Customers c JOIN payments p on c.customernumber=p.customernumber
WHERE c.state IS NOT NULL 
GROUP BY c.state 
ORDER BY sum(p.amount) DESC;
#Ans - California

#7.	Join customer, orderdetails, orders, products table and find the total quantity ordered for each productLine?

SELECT p.productline,sum(quantityOrdered) AS 'Total Quantity'
FROM orderdetails od JOIN products p ON od.productcode=p.productcode JOIN orders o ON o.ordernumber=od.ordernumber JOIN customers c ON c.customernumber=o.customernumber 
GROUP BY p.productline ;

#8.	Join all the tables to create the analytical dataset?
select * from 
productlines pl join products p on pl.productLine=p.productLine
join orderdetails odd on p.productCode=odd.productCode
join orders od on odd.orderNumber=od.orderNumber
join customers c on od.customerNumber=c.customerNumber
join employees e on c.salesRepEmployeeNumber=e.employeeNumber
join offices o on e.officeCode=o.officeCode
join payments py on py.customerNumber=c.customerNumber;


