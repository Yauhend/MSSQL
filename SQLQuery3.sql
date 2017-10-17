--use UNIVER;
--1.	Вывести информацию о студентах, которым на конец текущего года не исполниться   31 года

--select * from stud
--WHERE DATEDIFF ( YEAR , br_date, '2017-12-31')<31

----2.	Вывести средний возраст студентов по факультету, курсу и форме обучения

--select  faculty, year, form, avg(DATEDIFF ( YEAR , br_date, SYSDATETIME())) as avg_years
--from stud
--group by faculty, year, form

--3.	Вывести информацию о студентах, которым на текущий момент исполнился 31 год

--select * from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME())>=31

--4.	Найти количество  студентов от 32 до 45 лет

--select COUNT (*) 
--from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME()) between 32 and 45


--5.	Определить сколько студентов старше 45 лет учатся на каждом факультете на каждом курсе

--select  faculty, year,  COUNT (*) 
--from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME()) >= 45
--group by faculty, year 


--6.	Определит факультет,  на котором учится максимальное количество студентов до 35


--select top 1 faculty, count(*) as kolvo
--from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME()) < 35
--group by faculty
--order by  kolvo desc 


--select MAX(kolvo) as ttt from           --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--(select faculty, count(*) as kolvo
--from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME()) < 35
--group by faculty
-- ) as s
 





--7.	Определить факультет с минимальным числом студентов на заочной форме обучения

--select top 1 faculty, count(*) as kolvo
--from stud
--WHERE form = 'заочная'
--group by faculty
--order by  kolvo asc 


--8.	Определить факультет, на котором учится максимальное число первокурсников очников или заочников

-- select top 1 faculty, count(*) as kolvo
--from stud
--WHERE year = 1 and (form ='очная' or form='заочная')
--group by faculty
--order by  kolvo desc 

--9.	Определить факультет и курс, на которых средний возраст студентов меньше 32 лет

--select  faculty, year
--from stud
--group by faculty, year
--having avg(DATEDIFF ( YEAR , br_date, SYSDATETIME()))<32


--10.	Определить факультет и курс и общую численность курса на котором учится студенты не младше 25





--11.	Найти факультет и курс, на которых студентов без отчества обучается больше одного
--select  faculty, year, kolvo 
--from(
--select  faculty, year, COUNT(*) as kolvo
--from stud
--where s_name is NULL
--group by faculty, year) as s --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--where kolvo>=2


--12.	Вывести информацию о самом успевающем студенте университета.
--select * from stud
--where exm = (select  MAX(exm) from stud)

--13.	Вывести список форм обучения в университете

--select  distinct form from stud

--14.	Определить число форм обучения в университете на текущий момент

--select COUNT(distinct form) from stud

--15.	Определить число форм обучения на каждом факультете

--select faculty, COUNT(distinct form) from stud
--group by faculty


--16.	Определить общее количество иностранцев и студентов не иностранцев фамилии которых начинаются на букву С 



--17.	Определить процент учащихся иностранцев к  числу студентов в университете*
