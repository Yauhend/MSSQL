------1.	Вывести информацию о студентах, которым на конец текущего года не исполниться   31 года

----select * 
----from stud
----where DATEDIFF(year,br_date,'2017-12-31')<31
 

------2.	Вывести средний возраст студентов по факультету, курсу и форме обучения

----select faculty, year, form, avg(DATEDIFF(year,br_date,SYSDATETIME())) as avg_vozrast
----from stud
----group by faculty, year,form


------3.	Вывести информацию о студентах, которым на текущий момент исполнился 31 год

----select *
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME())>=31

------4.	Найти количество  студентов от 32 до 45 лет
----select count(*) as students_32_45
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME()) between 32 and 45

------5.	Определить сколько студентов старше 45 лет учатся на каждом факультете на каждом курсе

----select faculty, year, count(*) as students_over_45
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME())>45
----group by faculty, year

------6.	Определит факультет,  на котором учится максимальное количество студентов до 35

----select top 1 faculty, count(*) as kolvo
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME())<35
----group by faculty
----order by kolvo desc

------7.	Определить факультет с минимальным числом студентов на заочной форме обучения
--select  min(kolvo)
--from
--(

--select count(*) as kolvo
--from stud
--where form='заочная'
--group by faculty
--order by kolvo asc
--)
-- as x, 
------8.	Определить факультет, на котором учится максимальное число первокурсников очников или заочников 

----select top 1 faculty, count(*) as kolvo
----from stud
----where year=1
----group by faculty
----order by kolvo desc

------9.	Определить факультет и курс, на которых средний возраст студентов меньше 32 лет

----select faculty, year, avg(datediff(year,br_date,SYSDATETIME())) as avg_voz
----from stud
----group by faculty, year
----having avg(datediff(year,br_date,SYSDATETIME())) < 32


------10.	Определить факультет и курс и общую численность курса на котором учится студенты не младше 25
select y.faculty, y.year, count(*) as kolvo
from (select * from stud) as y, (
select distinct faculty, year
from stud
where datediff(year,br_date,SYSDATETIME())>=25
) as x
where y.faculty = x.faculty and y.year= x.year
group by y.faculty, y.year

------11.	Найти факультет и курс, на которых студентов без отчества обучается больше одного

--select faculty, year
--from(
--select faculty, year, count(*)as kolvo
--from stud
--where s_name is null 
--group by faculty, year
--) as x
--where kolvo>1

------12.	Вывести информацию о самом успевающем студенте университета.

--select top 1 *
--from stud
--order by exm desc


------13.	Вывести список форм обучения в университете

--select distinct form
--from stud

------14.	Определить число форм обучения в университете на текущий момент

--select count(*) as kolvo
--from(
--select distinct form
--from stud
--) as x

------15.	Определить число форм обучения на каждом факультете
--select faculty, count(*) as kolvo
--from(
--select distinct faculty, form
--from stud
--) as x
--group by faculty
------16.	Определить общее количество иностранцев и студентов не иностранцев фамилии которых начинаются на букву С 

--select count(*) as kolvo
 
--from stud
--where s_name is null or (last_name like 'С%' and s_name is not null)


------17.	Определить процент учащихся иностранцев к  числу студентов в университете*

--select cast((inost) as float)/vse*100 as kolvo
--from(
--select count(*) as inost 
--from stud
--where s_name is null
--) as x,
--(select count(*) as vse 
--from stud) as y

