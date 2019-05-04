#Query 1

use ClassicModels;

select customerName, productName, Orders.status
from Customers

join Orders 
on Customers.customerNumber = Orders.customerNumber

join OrderDetails
on Orders.orderNumber = OrderDetails.orderNumber

join Products
on OrderDetails.productCode = Products.productCode

Where Orders.status regexp 'In Proc';


#Query 2

Select Customers.customerNumber, Customers.customerName

from Customers

where not exists

(select *
from Orders
where Customers.customerNumber = Orders.customerNumber)

order by customerName;



#c. Write a query to list the different offices (their address), count of the number
#of employees at that office and the number of orders that employees at that
#office were sales representatives for. 

Select Offices.officeCode, Offices.addressLine1, count(distinct(Customers.salesRepEmployeeNumber)), count(Orders.orderNumber)
from Offices

join Employees
on Employees.officeCode = Offices.officeCode

join Customers
on Employees.employeeNumber = Customers.salesRepEmployeeNumber

join Orders 
on Customers.customerNumber = Orders.customerNumber

join OrderDetails
on Orders.orderNumber = OrderDetails.orderNumber

where Employees.jobTitle = 'Sales Rep'

Group by Offices.officeCode;


#Q4

select employee.lastName, employee.firstName, employee.jobTitle, employee.extension, employee.reportsTo
from Employees as employee
join Employees as boss
on boss.employeeNumber = employee.reportsTo
where boss.jobTitle = employee.jobTitle;


 #Q5
 
 select Employees.lastName, Employees.firstName, SUM(priceEach*quantityOrdered) as 'Amount Sold'
 
from Employees

join Customers
on Employees.employeeNumber = Customers.salesRepEmployeeNumber

join Orders 
on Customers.customerNumber = Orders.customerNumber

join OrderDetails
on Orders.orderNumber = OrderDetails.orderNumber

group by Employees. employeeNumber

order by SUM(priceEach*quantityOrdered) desc;



select Employees.lastName, Employees.firstName
 
from Employees

join Customers
on Employees.employeeNumber = Customers.salesRepEmployeeNumber

join Orders 
on Customers.customerNumber = Orders.customerNumber

join OrderDetails
on Orders.orderNumber = OrderDetails.orderNumber

where priceEach > avg(priceEach);

 







