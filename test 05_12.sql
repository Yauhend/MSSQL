--1.	вывести список факультетов, на которых имеется вечерняя форма обучения.

select distinct faculty.faculty_name 
from faculty
	join hours on hours.faculty_id = faculty.id
	join form on form.id = hours.form_id
where form.form_name = 'вечернее'

--2.	Вывести номер курса и количество часов для него для ФПМ очной формы обучения

select hours.course, hours.all_h  
from hours
	join faculty on faculty.id = hours.faculty_id
	join form on form.id = hours.form_id
where faculty.faculty_name = 'ФПМ' and form.form_name = 'очно'

--3.	Вывести список всех студентов с перечнем факультетов, на которых они учатся

select stud.*, faculty.faculty_name
from stud
	join process on process.stud_id = stud.id
	join hours on hours.id = process.hours_id
	join faculty on faculty.id = hours.faculty_id

--4.	Вывести информацию о самом старшем студенте института (Факультет, форма, курс, фио)

select top 1 with ties faculty.faculty_name, form.form_name, hours.course, stud.last_name, stud.f_name, stud.s_name
from stud
	join process on process.stud_id = stud.id
	join hours on hours.id = process.hours_id
	join faculty on faculty.id = hours.faculty_id
	join form on form.id = hours.form_id
order by stud.br_date asc

--5.	Вывести список студентов, поступивших в институт на ФПК в 2014

select stud.*
from stud
	join process on process.stud_id = stud.id
	join hours on hours.id = process.hours_id
	join faculty on faculty.id = hours.faculty_id
where faculty.faculty_name = 'ФПК' and stud.in_date like '%2014%'
