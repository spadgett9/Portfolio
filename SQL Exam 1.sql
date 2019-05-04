use ClassicModels;

#select name of cust, order stat, Count(number order in different order statuses)\

select Orders.status, Customers.customerName, count(status) as "Number orders in status"
from Customers
join Orders
on Customers.customerNumber = Orders.customerNumber
group by customerName;

#Q2: f name, lname of emp = sales rep but not sales rep for cust

select firstName, lastName
from Employees
join Customers
on Employees.employeeNumber = Customers.salesRepEmployeeNumber
where jobTitle = "Sales Rep"
and not exists
(select * 
from Employees
where Employees.employeeNumber = Customers.salesRepEmployeeNumber);


#Q3: product name, product line, (where diff between msrp and buyPrice > avg(msrp and buyPrice)) order by product line(asc) and difference in desc


select Products.productName, Products.productLine, (MSRP-buyPrice) as "Difference MSRP and Buy"
from ProductLines
join Products
on ProductLines.productLine = Products.productLine
where MSRP-buyPrice>(select avg(msrp-buyPrice) from Products)
order by Products.productline, (MSRP-buyPrice) Desc;





#Q4: list country (customers) number of orders placed customers in country as percentage total orders. desc order of %

select Customers.country, (count(Orders.orderNumber)/(select count(orderNumber) from Orders)) as "Percentage Orders per Country"
from Customers
join Orders
on Customers.customerNumber = Orders.customerNumber
group by Customers.country
order by (count(Orders.orderNumber)/(select count(orderNumber) from Orders)) DESC;


#Q5: customers in spain without orders

Select customerName, count(orderNumber)
from Customers
join Orders
on Customers.customerNumber = Orders.customerNumber
group by country
having country="Spain"
and 0 = (select count(orderNumber) from Orders);

#Q6: first and last name employee reports to someone with same last name

select emp.lastName, emp.firstName
from Employees as emp
join Employees as boss
on boss.employeeNumber = emp.reportsTo
where boss.lastName = emp.lastName;

#Q7: list customer name, customer country. total orders by customers of that country. only countrys more than 10 orders.alter

select customerName, country, count(orderNumber)
from Customers
join Orders
on Orders.customerNumber = Customers.customerNumber
group by country
having (select count(orderNumber) from Orders) > 10;