----Создайте представление
----- с информацией ФИО, курс, форма обучения всех студентов ФПК
--create view v_first
--as
select stud.id, stud.last_name, stud.f_name, stud.s_name, hours.course, form.form_name 
from stud
	join process on process.stud_id = stud.id
	join hours on hours.id = process.hours_id
	join faculty on faculty.id = hours.faculty_id
	join form on form.id = hours.form_id
where faculty.faculty_name = 'ФПК'

----- с информацией Факультет, курс, количество общих , в которое войдут курсы заочной формы обоих факультетов, но только те по которым число общих часов обучения максимально
--create view v_second
--as
select  x.faculty_name, x.course, x.all_h
from (
	select faculty.faculty_name, hours.course, hours.all_h, hours.faculty_id 
	from hours
		join faculty on faculty.id = hours.faculty_id
) as x,		
(
	select max(all_h) as maxhours, faculty_id 
	from hours 
		join form on form.id = hours.form_id 
	where form.form_name = 'заочно'  
	group by faculty_id
) as y
where x.faculty_id = y.faculty_id and x.all_h=y.maxhours


----- с информацией об отличниках на каждом курсе, каждого факультета , каждой формы обучения и их среднем бале 
--create view v_third
--as
select y.id, y.f_name, y.last_name, y.exm, y.course, y.faculty_name, y.form_name
from(
	select max(stud.exm) as maxball, course, faculty_id, form_id
	from stud
		join process on process.stud_id = stud.id
		join hours on hours.id = process.hours_id	
	group by course, faculty_id, form_id
) as x,
(
	select stud.*, course, faculty_name, form_name, faculty_id, form_id	
	from stud
		join process on process.stud_id = stud.id
		join hours on hours.id = process.hours_id
		join form on form.id = hours.form_id
		join faculty on faculty.id = hours.faculty_id
) as y
where x.course = y.course and x.faculty_id = y.faculty_id and x.form_id = y.form_id and x.maxball = y.exm


----- с информацией о слабоуспевающих студентах и их среднем бале
--create view v_fourth
--as
select * 
from stud
where exm < (select avg(exm) from stud)


--- определите какие из созданных представлений являются модифицирующими, а какие только_чтение и почему

--'v_fourth - модифицирующий, остальные нет, так как включают данные из нескольких таблиц'

--На основании первого представления переведите студента Слободницкий на факультет ФПМ, сделайте повторно  выборку  первого представления

-- можно я его переведу на  другой курс?

update v_first
set course = 3
where last_name = 'Слободницкий'


select * from v_first


