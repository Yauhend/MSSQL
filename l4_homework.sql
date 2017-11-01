------Задание к лабораторной работе №4

------1.	Вывести информацию о первых трех студентах (факультет, курс) заочной формы обучения младше 30 лет

select top 3 stud.*, faculty.faculty_name, hours.course from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'заочно' and DATEDIFF ( YEAR , stud.br_date, SYSDATETIME()) < 30

------2.	Вывести информацию о первых пяти студентах (факультет, курс) заочной формы обучения старше 25 лет

select top 5 stud.*, faculty.faculty_name, hours.course from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'заочно' and DATEDIFF ( YEAR , stud.br_date, SYSDATETIME()) >= 25

------3.	Определить количество студентов на каждом факультете
select COUNT(*) as Chislo_studentov, faculty.faculty_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty_name

 ------или даже лучше так

select COUNT(*) as Chislo_studentov, faculty.faculty_name from process 
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty_name

------4.	Определить количество студентов, учащихся на каждой форме обучения

select COUNT(*) as Chislo_studentov, form.form_name from process 
join hours on process.hours_id = hours.id
join form on hours.form_id = form.id
group by form.form_name

------5.	Определить средний возраст студентов для каждого факультета на конец года (лет)

select avg(DATEDIFF ( YEAR , stud.br_date, '2017-12-31')) as sr_vozrast, faculty.faculty_name  from stud
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty.faculty_name


--------6.	Найти всех студентов-иностранцев (без отчества), вывести сведения о них (дата поступления, факультет, курс, форма обучения)

select  stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where stud.s_name is null

------7.	Определить общее количество аудиторных часов за весь период обучения для студентов очников ФПМ

select sum(hours.inclass_h) as summa_chasov from hours 
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'очно' and faculty.faculty_name ='ФПМ'

------8.	Определить общее количество часов согласно плану для студентов заочной формы обучения ФПК заочной формы обучения

select sum(hours.all_h) as summa_chasov from hours 
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'заочно' and faculty.faculty_name ='ФПК'

------9.	Определить всех сокурсников (с учетом факультета, но разных форм обучения) студента Ботяновского 

select stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where faculty.id =  -- вдруг он сразу на двух учится, тогда сюда поставить any и убрать топ 1
	(select top 1 hours.faculty_id from stud 
	join process on stud.id = process.stud_id
	join hours on process.hours_id = hours.id
	where stud.last_name = 'Ботяновский')
and stud.last_name <> 'Ботяновский'

------10.	Определить на какой факультет поступило наибольшее количество человек в 2015 году

select top 1 faculty.faculty_name, COUNT (process.stud_id) as kol_post_v_2015 from stud
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
where stud.in_date like '2015%'
group by faculty.faculty_name

------11.	Вывести список студентов, которые учатся на тех же  курсах, что и студент Зингель и студентка Зайцева

select stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where hours.course = any --вот такой случай
	(select  hours.course from stud 
	join process on stud.id = process.stud_id
	join hours on process.hours_id = hours.id
	where stud.last_name = 'зингель' or stud.last_name = 'зайцева')


------12.	Вывести список студентов по факультетам, средний балл которых меньше  7

select  faculty.faculty_name, stud.* from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where stud.exm < 7
order by faculty.faculty_name, stud.exm desc

------13.	Вывести список студентов, средний балл которых меньше чем средний по институту

--тут, наверное, стоит усложнить или по другому сформулировать задание))
select  * from stud 
where exm < (select AVG(exm) from stud)
order by exm desc

------14.	 Вывести список студентов, средний бал которых выше чем по их факультету
select  stud.*, x.faculty_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty as x on hours.faculty_id = x.id
where exm > (select AVG(exm) from stud
				join process on stud.id = process.stud_id
				join hours on process.hours_id = hours.id
				join faculty on hours.faculty_id = faculty.id
				where faculty.id = x.id
				)
order by x.faculty_name, stud.exm desc

---- для проверки значения среднего балла по факультетам
select AVG(exm), faculty.faculty_name from stud
				join process on stud.id = process.stud_id
				join hours on process.hours_id = hours.id
				join faculty on hours.faculty_id = faculty.id
				group by faculty.faculty_name