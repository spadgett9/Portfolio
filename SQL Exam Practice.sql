CREATE TABLE ATHLETE (        
Ath_Id  VARCHAR(5) ,  
Ath_F_Nm  VARCHAR(25) ,  
Ath_L_Nm VARCHAR(25),     
Ath_Status CHAR(2), 
Ath_Mentor VARCHAR(5) ,  
Ath_Team_Id CHAR(5), 
PRIMARY KEY(Ath_Id));



#Q1


select sen.Ath_FNm, sen.Ath_Id
from ATHLETE as mem
join ATHLETE as sen
on sen.Ath_Id = mem.Ath_Mentor
group by sen.Ath_Id 
having count(mem.Ath_Id)>1;


#Q2

Select Orig.Team_Nm
from Team as Orig
join Team as Counter
on Counter.Team_ID = Orig.Team_Counter
where Counter.Team_Cost<Orig.Team_Cost
and Orig.Team_Id RegExp "^F";


#Q3

#select: name and id. Athletes who are mentors part of rec team

select Mentor.Ath_ID
from Athlete as Play
join Athlete as Mentor
on Mentor.Auth_Id = Play.Auth_Mentor
join Team
on Mentor.AthTeam_Id = Team.Team_Id
where Team.Team_Level = "R";


#Q4

#id and name of ath mentored  "Andy Abad" . order DEC ath least nam
#when same last name, asc order id


select Play.Ath_Nm
from Athlete as Play
join Athlete as Mentor
on Mentor.Ath_Id = Play.Ath_Mentor
where Mentor.Ath_L_Nm = "Abad"
and Mentor.Ath_F_Nm = "Andy"
order by Play.Ath_L_Nm Desc, Ath_Id;

#Q5: select team id name level. where cost<60 and R OR where cost<100 and C

#Q6: list compeditive teams (id name). where rec counterart with senior capitan


from Athlete as Play
join Athlete as Ment
on Ment.Ath_Id = Play.Ath_Mentor
join Team as Orig
on Ment.Ath_Team_Id = Orig.Team_Id
join Team as Counter
on Counter.Team_Id = Orig.Team_Counter
where 


#list all prerq ID's for "Corporate Fin"



Select C1.Desc, C2.Creds
from Course as C1
join Preq 
on C1.courseID = Preq.courseID
join Course as C2
on preq.preqID = C2.CourseId
where C2.coarseDescript = "Finance2"


