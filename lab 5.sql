--Задание к лабораторной работе №5

---11.	 Вывести список студентов которые учатся, на факультетах, курсах и формах на которых учится не более одного иностранца(без отчества) 

select stud.* 
from stud
	join process	on process.stud_id = stud.id
	join hours		on hours.id = process.hours_id 
	join
		(select faculty_id, course, form_id, COUNT(*)-COUNT(s_name) as kolvo
		from stud 
			join process	on process.stud_id = stud.id
			join hours		on hours.id = process.hours_id		
		group by faculty_id,course, form_id)
		as st1
on st1.faculty_id=hours.faculty_id and st1.form_id=hours.form_id and st1.course = hours.course
where st1.kolvo<2

--______
--14.	Вывести список всех студентов, при этом для студентов иностранцев вывести название факультета и форму обучения

select 
	stud.*, 
	inost.faculty_name,
	inost.form_name 
from stud
	left join (	select 
					stud.id, 
					faculty.faculty_name, 
					form.form_name 
				from stud
					join process	on process.stud_id = stud.id
					join hours		on hours.id = process.hours_id
					join faculty	on faculty.id = hours.faculty_id
					join form		on form.id = hours.form_id
				where stud.s_name is null) 
				as inost on inost.id = stud.id

--15.	Вывести список факультетов, для каждого факультета вывести список форм обучения и номера курсов, для первых курсов вывести количество общих часов
select 
	faculty.faculty_name, 
	form.form_name, 
	hours.course, 
	first.all_h 
from faculty
	join hours	on hours.faculty_id = faculty.id
	join form	on form.id = hours.form_id
	left join (	select 
					hours.id, 
					hours.all_h 
				from faculty
					join hours	on hours.faculty_id = faculty.id
					join form	on form.id = hours.form_id
				where hours.course = 1) 
				as first	on first.id = hours.id;

--16.	Вывести список иностранцев, с указанием общего числа студентов обучающихся с ними на потоке (один факультет, курс, форма)

select
	stud.last_name,
	stud.f_name, 
	kolvo
from stud 
	join process	on process.stud_id = stud.id
	join hours		on hours.id = process.hours_id
	join (	select 
				hours.id,
				COUNT(*) as kolvo 
			from stud
				join process	on process.stud_id = stud.id
				join hours		on hours.id = process.hours_id
			group by hours.id) 
			as x	on x.id = hours.id 
where stud.s_name is null;


--17.	Вывести список форм обучения института, для очной и заочной посчитать количество студентов 
select 
	form_name,
	x.kolvo	
from form
	left join (	select 
				form.id, 
				COUNT(*) as kolvo 
			from stud
				join process	on process.stud_id = stud.id
				join hours		on hours.id = process.hours_id
				join form		on form.id = hours.form_id
			where form_name = 'очно'
				or form.form_name = 'заочно'
			group by form.id)
			as x	on x.id = form.id;

			

--18.	Вывести список факультетов, с указанием числа студентов обучающихся на каждой форме обучения  

select 
	faculty.faculty_name,
	ochno,
	zaochno,
	vechernee 
from faculty
	left join(	select 
					hours.faculty_id,
					COUNT(*) as ochno
				from stud
					join process	on process.stud_id = stud.id
					join hours		on hours.id = process.hours_id
					join form		on form.id = hours.form_id
				where form.form_name = 'очно'
				group by hours.faculty_id )
				as oc	on oc.faculty_id = faculty.id
	left join(	select 
					hours.faculty_id,
					COUNT(*) as zaochno
				from stud
					join process	on process.stud_id = stud.id
					join hours		on hours.id = process.hours_id
					join form		on form.id = hours.form_id
				where form.form_name = 'заочно'
				group by hours.faculty_id )
				as zao on zao.faculty_id = faculty.id
	left join(	select 
					hours.faculty_id,
					COUNT(*) as vechernee
				from stud
					join process	on process.stud_id = stud.id
					join hours		on hours.id = process.hours_id
					join form		on form.id = hours.form_id
				where form.form_name = 'вечернее'
				group by hours.faculty_id ) 
				as ve on ve.faculty_id = faculty.id