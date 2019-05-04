#Questoin 1

select FoodName, OrgName
from Food
join FoodRisk
on Food.FoodID = FoodRisk.FoodID
join Organism
on FoodRisk.OrgID = Organism.OrgId
where FoodRisk.RiskLevel IN('Very High');

#question 2

Select Organism.OrgName, CasesPerYear
from Organizm
join FoodRisk
on Organism.OrgID = FoodRisk.OrgID;

#question 3

select Food.FoodName, FoodRisk.CasesPerYear, FoodRisk.RiskLevel
from Food
join FoodRisk
on Food.FoodID = FoodRisk.FoodID
join Organism
on FoodRisk.OrgID = Organism.OrgId
Group by FoodID
having Food.FoodName IN('Raw Seafood', 'Fruits', 'Hard Cheese');

#Question 4

select appl_f_nm, appl_l_nm, appl_phone, pet_nm
from Applicant
join Adoption
on Applicant.appl_id = Adoption.appl_id
join Pet
on Adoption.pet_id = Pet.pet_id
where pet_animal = 'Cat'
and adpt_date between #dates
order by appl_l_nm;


#Question 5

select shelter_nm, shelter_phone, Pet.pet_id, pet_nm
from Applicant
join Adoption
on Applicant.appl_id = Adoption.appl_id
join Pet
on Adoption.pet_id = Pet.pet_id
join Shelter
on Shelter.shelter_id = Pet.shelter_id
where pet_sex = 'F'
and pet_breed IN(breeds);

#Queston 6

select Avg(emp_yr_joined)
from Employee
join Section 
on Employee.sec_id = Section.sec_ID
group by sec_nm
having not in('Viola')
order by emp_yr_joined; 

select emp_yr_joined, emp_l_nm, emp_f_nm
from Employee





