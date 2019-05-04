#find all departments where all employees  earn less than their boss.

use Text;

select deptname
from emp
join dept
on emp.bossno = dept.empno

select dept.deptname, avg(emp.empsalary)
from dept
join emp
on dept.empno = emp.empno
group by dept.deptname
having 25000 < (select avg(emp.empsalary) from emp);

select worker.empfname as 'Worker Name', boss.empfname as 'boss name'
from emp as worker
join emp as boss
on worker.bossno = boss.empno
join dept
on worker.empno = dept.empno
where dept.deptname = "Marketing"
and worker.empsalary > 25000;

select count(montype)
from monarch
where montype = "King";


#prodid = 1000
select sum(assembly.quantity*product.prodcost)
from assembly
join product
on product.prodid=assembly.prodid
where product.prodid='1000'
group by product.prodid;



