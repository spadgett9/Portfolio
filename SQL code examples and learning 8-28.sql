use Text;



select *
from share
order y shrprice DESC;  #this sets to descending order in our column


########## NUMERIC OPERATORS ################
# we want to kon how many records are in our data

select COUNT(SHRDIV), MIN(SHRDIV) as 'mIN SHARED DIV.' #the as function allows to name to new column
from ;

# COUNT, MIN, MAX, SUM


############################################

################ SUB QUERIES ###############


#the as funtion is a sub or neted query

select *
from share
where shrdiv=(select MAX(shrdiv) from share));



use Chapter3;

select *
from item;

select *
from item
where item_price>25;


select item_name
from item
where item_price > 100;


select AVG(item_price)
from item
where item_category='toy';

select item_name, item_price
from item (select * from item where item_category='toy')
where item_price>(select AVG(item_price) from item where item_category='toy');


select *
from item
where item_category='toy'
AND item_price > (SELECT AVG(item_price) FROM item where item_category = 'toy');


select *
from item
order y item_price DEC;



use Text;

SELECT * 
FROM share
WHERE shrfirm REGEXP 'ee'; #finds all with ee anywhere in text



SELECT * 
FROM share
WHERE shrfirm REGEXP '^B';    #were text begins with a B


SELECT * 
FROM share
WHERE shrfirm REGEXP 'B$';    #were text ends with a E

select distinct shrpe    # selects unique values from a columt
from share;

seect *
from share
where 
shrprice between 10 and 30;


















