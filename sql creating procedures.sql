use ClassicModels;

create Procedure customersInUSA()
select * from Customers
where country = "USA";

call customersInUSA;

create procedure CustomersIn(param carchar(8))
select * 
from Customers 
where country = param;