--«адание к лабораторной работе є5

--______
--14.	¬ывести список всех студентов, при этом дл€ студентов иностранцев вывести название факультета и форму обучени€

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

--15.	¬ывести список факультетов, дл€ каждого факультета вывести список форм обучени€ и номера курсов, дл€ первых курсов вывести количество общих часов
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

--16.	¬ывести список иностранцев, с указанием общего числа студентов обучающихс€ с ними на потоке (один факультет, курс, форма)

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


--17.	¬ывести список форм обучени€ института, дл€ очной и заочной посчитать количество студентов 
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

			

--18.	¬ывести список факультетов, с указанием числа студентов обучающихс€ на каждой форме обучени€  

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