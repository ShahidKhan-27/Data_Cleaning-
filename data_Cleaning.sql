-- Performance Data Wrangling and Data Cleaning to CLean and Transform the data --
use sql_project;
select * from attacks;

select * from attacks
where Date is null
and `Case Number`is null; 

-- Deleting all rows that contains NULLs in any of the column (Exception is 'Species' which we will deal at Later) --

delete from attacks
where Date is null
or `Case Number` is null
or Type is null
or Activity is null
or Age is null 
or Time is null
or Location is null
or Name is null
or Area is null
or Injury is null;

-- Row with type as 'Invalid' --
select *from attacks
where type='Invalid';

-- 7 types of Shark Attacks ,two are similar i.e Boat and Boating likely refer to same type. we will update Boat with  Boating--
select distinct(Type) from attacks;

update attacks 
set Type = 'Boating'
where Type = 'Boat'; 

-- IN activity some Field are misspelt like Surfing is and Showing in Multiple format due to end space  --
select distinct (activity) ,count(activity) from attacks
group by activity;

update attacks
set Activity  = 'Fishing'
where Activity = 'Fishing ';

update attacks
set Activity  = 'Surfing'
where Activity = 'Surfing ';

-- In name column Gender is mention Like male 29  female 10 and blank 4 with Multiple rows  --

select distinct(Name) , count(Name) from attacks
group by Name ;

update attacks
set Name ='Unknown'
where Name in  ('male','female','');

-- Removing White Space (9 rows) from Name --
Update attacks
set Name = trim(Name);

-- In Species 62 is Blank --
select distinct(Species),count(Species) from attacks
group by Species;

Update attacks
set Species = "Unknown"
where Species ='';

-- IN Injuries  Field 'FATAL' should 'Fatal'--
select Injury from attacks;
Update attacks
set Injury='Fatal'
where Injury = 'FATAL'; 

-- Wrangling Country Column ,Changing values From UPPER To Proper Case --
select country from attacks;

Select concat(Upper(substring(country,1,1)), Lower(substring(country,2,length(country)))) as "Country Proper Case"
from attacks;

update attacks
set Country = concat(Upper(substring(country,1,1)), Lower(substring(country,2,length(country))));

-- Rename Column 'Sex' to 'Gender' --
alter table attacks
rename column Sex to Gender; 

alter table attacks 
rename column `Fatal (Y/N)` to Fatal;

-- Wrangling the time Column --
Select Time,substring(time,1,2) from attacks;

update attacks
set time = 'Unknown'
where time = '';

select time , substring(time,1,2),
case 
when substring(time ,1,2) <'04' then "Pre-down"
when substring(time ,1,2)>='04' and substring(time ,1,2)<'07'then "Early Morning"
when (substring(time ,1,2)>='07' or substring(time ,1,1)>='7') and substring(time ,1,2)<'10' then "Morning"
when substring(time ,1,2)>='10' and substring(time ,1,2)<'12' then "Early Noon"
when substring(time ,1,2)>='12' and substring(time ,1,2)<'13' then 'Noon'
when substring(time ,1,2)>='13' and substring(time ,1,2)<'15' then 'Afternoon'
when substring(time ,1,2)>='15' and substring(time ,1,2)<'16' then 'Early Evening'
when substring(time ,1,2)>='16' and substring(time ,1,2)<'18' then 'Evening'
when substring(time ,1,2)>='18' and substring(time ,1,2)<'20' then 'Late Evening'
when substring(time ,1,2)>='20' and substring(time ,1,2)<'22' then 'Night'
when substring(time,1,2)>='22' then 'Late Night'
else time 
end as Attacks_Time 
from Attacks
order by Attacks_Time;

Update Attacks
set Time = (case 
when substring(time ,1,2) <'04' then "Pre-down"
when substring(time ,1,2)>='04' and substring(time ,1,2)<'07'then "Early Morning"
when (substring(time ,1,2)>='07' or substring(time ,1,1)>='7') and substring(time ,1,2)<'10' then "Morning"
when substring(time ,1,2)>='10' and substring(time ,1,2)<'12' then "Early Noon"
when substring(time ,1,2)>='12' and substring(time ,1,2)<'13' then 'Noon'
when substring(time ,1,2)>='13' and substring(time ,1,2)<'15' then 'Afternoon'
when substring(time ,1,2)>='15' and substring(time ,1,2)<'16' then 'Early Evening'
when substring(time ,1,2)>='16' and substring(time ,1,2)<'18' then 'Evening'
when substring(time ,1,2)>='18' and substring(time ,1,2)<'20' then 'Late Evening'
when substring(time ,1,2)>='20' and substring(time ,1,2)<'22' then 'Night'
when substring(time,1,2)>='22' then 'Late Night'
else time 
end);
 
-- Rename 'Attack' Column 'Attack_Time' --
alter table attacks
rename column Time to Attack_Time ;

-- Final Check Table --
Select * from Attacks;
