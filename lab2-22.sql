--using UNIVER
--7.	Определить средний балл на заочной форме обучения каждого факультета.

select faculty, avg(exm) as average_ball
from stud
where form = 'заочная'
group by faculty


--8.	Найти значения максимальных средних баллов для каждого факультета и курса

select faculty, year, max(exm) as max_av_ball
from stud
group by faculty, year

--9.	Определить список факультетов, средний балл успеваемости на которых больше 7.5

select faculty, avg(exm) as average_ball
from stud
group by faculty
having avg(exm) > 6.5

--10.	Определить список курсов с указанием факультета, средний балл успеваемости на которых больше 7.5

select year, faculty, avg(exm) as average_ball
from stud
group by year, faculty
having avg(exm) > 6.5

--11.	Определить форму обучения с привязкой к факультету, для которой минимальный балл успеваемости для одного из студентов меньше 7.

select form, faculty, min(exm) as minimal_avg
from stud
group by form, faculty
having min(exm) < 7
  
--12.	 Определить, какое количество часов студенты ФПК 3-го курса заочной формы обучения тратят на самостоятельную подготовку

select  avg(all_h - inclass_h) as inhome_h
from stud
where faculty = 'ФПК' and year = 3 and form = 'заочная'

--или

select  distinct (all_h - inclass_h) as inhome_h
from stud
where faculty = 'ФПК' and year = 3 and form = 'заочная'


--13.	Вывести список факультетов, курсов, форм обучения на которых студенты тратят более 150 часов на самостоятельную подготовку

select distinct faculty, year, form 
from stud
where (all_h-inclass_h)>150


--14.	определить среднее число часов, которое тратит студент факультета для каждой формы обучения за один год  на этой форме.

select faculty, form, avg(all_h) as avg_all_hours
from stud
group by faculty, form
