------Задание к лабораторной работе №4

------1.	Вывести информацию о первых трех студентах (факультет, курс) заочной формы обучения младше 30 лет



--select  x.* from (select top 3 * from stud
--where id = some (select stud_id from process 
--           where hours_id = some (select id from hours 
--		         where form_id = some (select id from form 
--				       where form_name = 'заочно')))
--and  DATEDIFF(year,br_date,SYSDATETIME())<30
--order by DATEDIFF(year,br_date,SYSDATETIME()))as x

--select stud.*, process.hours_id 
--from stud
--inner join process on stud.id = process.stud_id

--select  stud.*, x.faculty_name from stud
--inner join
--(select process.stud_id, faculty.faculty_name 
--from hours
--inner join faculty on hours.faculty_id = faculty.id
--inner join process on hours.id = process.hours_id
--where form_id = 2 ) as x



--where DATEDIFF(year,br_date,SYSDATETIME())<30
--order by DATEDIFF(year,br_date,SYSDATETIME())
--some (select id from form where form_name = 'заочно')


select process.stud_id, faculty.faculty_name 
from hours
inner join faculty on hours.faculty_id = faculty.id
inner join process on hours.id = process.hours_id
where form_id = some (select id from form where form_name = 'заочно')


------2.	Вывести информацию о первых пяти студентах (факультет, курс) заочной формы обучения старше 25 лет
------3.	Определить количество студентов на каждом факультете
------4.	Определить количество студентов, учащихся на каждой форме обучения
------5.	Определить средний возраст студентов для каждого факультета на конец года (лет)
------6.	Найти всех студентов-иностранцев (без отчества), вывести сведения о них (дата поступления, факультет, курс, форма обучения)
------7.	Определить общее количество аудиторных часов за весь период обучения для студентов очников ФПМ
------8.	Определить общее количество часов согласно плану для студентов заочной формы обучения ФПК заочной формы обучения
------9.	Определить всех сокурсников (с учетом факультета, но разных форм обучения) студента Ботяновского 
------10.	Определить на какой факультет поступило наибольшее количество человек в 2015 году
------11.	Вывести список студентов, которые учатся на тех же  курсах, что и студент Зингель и студентка Зайцева
------12.	Вывести список студентов по факультетам, средний балл которых меньше  7
------13.	Вывести список студентов, средний балл которых меньше чем средний по институту
------14.	 Вывести список студентов, средний бал которых выше чем по их факультету
