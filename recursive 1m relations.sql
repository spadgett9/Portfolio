use Text;

#writing a wuery on recursive many to many. remember, youre creating another tables


select mainproduct.proddesc, count(distinct subproduct.prodid)
from product as mainproduct
join assembly on mainproduct.prodid = assembly.prodid
join product as subproduct on assembly.subprodid = subproduct.prodid
group by mainproduct.prodid;


select mainproduct.proddesc, sum(quantity*subproduct.prodcost)
from product as mainproduct
join assembly on mainproduct.prodid = assembly.prodid
join product as subproduct 
on assembly.subprodid = subproduct.prodid
group by mainproduct.prodid;