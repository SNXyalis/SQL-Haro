--QUERIES


--I
select n Name, sum(cc) total
from
(select c.country_name n, count(*) cc
from vaccinations v 
join population p on v.vuid=p.puid
join countries c on p.country=c.country_code
where v.first_dose='TRUE'
group by c.country_name
union
select c.country_name n, count(*) c1
from vaccinations v 
join population p on v.vuid=p.puid
join countries c on p.country=c.country_code
where v.first_dose='TRUE' and v.second_dose='TRUE'
group by c.country_name)
group by n
order by total desc
fetch first 1 rows only;





--II
select vc.country,c.country_name,count(*)
from Vaccination_Centers vc join countries c on vc.country=c.country_code 
group by vc.country,c.country_name;




--III
select n Name, sum(cc) total
from
(select c.country_name n, count(*) cc
from vaccinations v 
join population p on v.vuid=p.puid
join countries c on p.country=c.country_code
where v.first_dose='TRUE'
group by c.country_name
union
select c.country_name n, count(*) c1
from vaccinations v 
join population p on v.vuid=p.puid
join countries c on p.country=c.country_code
where v.first_dose='TRUE' and v.second_dose='TRUE'
group by c.country_name)
where n='Greece'
group by n
order by total desc;


--IV
select b Brand, sum(cc) total
from
(select c.brand_id b, count(*) cc
from vaccinations v
join vaccine_companies c on v.vaccine_type=c.brand_id
where v.first_dose='TRUE'
group by c.brand_id
union
select c.brand_id b, count(*) c1
from vaccinations v
join vaccine_companies c on v.vaccine_type=c.brand_id
where v.first_dose='TRUE' and v.second_dose='TRUE'
group by c.brand_id)
group by b
order by total desc;





--V
select *  from(
select first_dose_date HMEROMHNIA,count(*) AM_OF_VACCS
from vaccinations
where (First_dose ='TRUE')
group by first_dose_date
union 
select second_dose_date,count(*) 
from vaccinations
where (second_dose ='TRUE'  )
group by second_dose_date)
where AM_OF_VACCS=

(select max(AM_OF_VACCS)  from(
select first_dose_date HMEROMHNIA,count(*) AM_OF_VACCS
from vaccinations
where (First_dose ='TRUE')
group by first_dose_date
union 
select second_dose_date,count(*) 
from vaccinations
where (second_dose ='TRUE'  )
group by second_dose_date));



--VI
select count(*)
from vaccinations v join population p on v.vuid=p.puid 
where v.First_dose ='TRUE' and v.Second_dose ='TRUE';


--VII
With table1 as ( 
      SELECT COUNT(*) as nr1
      FROM population
), 
table2 as (
     select count (*) as nr2
     from vaccinations 
     where First_dose ='TRUE'
)
SELECT  round ((table2.nr2 / table1.nr1)*100,4)||'%'  as PERCENT_OF_VACCINATED_PEOPLE
FROM table1
CROSS JOIN table2;
