


select faculty, year, count(*) as kolichestvo 
from stud
where id  != all	(select id from stud as x, 
					(select distinct faculty, year from stud
					where datediff(year,br_date,SYSDATETIME())<25) as y
					where x.faculty=y.faculty and x.year = y.year)
group by faculty, year


select faculty, year, count(*) as kolichestvo
from stud
where faculty+CONVERT(varchar(1),year)
not in (select distinct faculty+CONVERT(varchar(1),year) from stud
where datediff(year,br_date,SYSDATETIME())<25)
group by faculty, year

select distinct faculty+CONVERT(varchar(1),year) from stud