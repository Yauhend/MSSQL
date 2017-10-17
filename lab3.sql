------1.	������� ���������� � ���������, ������� �� ����� �������� ���� �� �����������   31 ����

----select * 
----from stud
----where DATEDIFF(year,br_date,'2017-12-31')<31
 

------2.	������� ������� ������� ��������� �� ����������, ����� � ����� ��������

----select faculty, year, form, avg(DATEDIFF(year,br_date,SYSDATETIME())) as avg_vozrast
----from stud
----group by faculty, year,form


------3.	������� ���������� � ���������, ������� �� ������� ������ ���������� 31 ���

----select *
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME())>=31

------4.	����� ����������  ��������� �� 32 �� 45 ���
----select count(*) as students_32_45
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME()) between 32 and 45

------5.	���������� ������� ��������� ������ 45 ��� ������ �� ������ ���������� �� ������ �����

----select faculty, year, count(*) as students_over_45
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME())>45
----group by faculty, year

------6.	��������� ���������,  �� ������� ������ ������������ ���������� ��������� �� 35

----select top 1 faculty, count(*) as kolvo
----from stud
----where DATEDIFF(year,br_date,SYSDATETIME())<35
----group by faculty
----order by kolvo desc

------7.	���������� ��������� � ����������� ������ ��������� �� ������� ����� ��������
--select  min(kolvo)
--from
--(

--select count(*) as kolvo
--from stud
--where form='�������'
--group by faculty
--order by kolvo asc
--)
-- as x, 
------8.	���������� ���������, �� ������� ������ ������������ ����� �������������� ������� ��� ��������� 

----select top 1 faculty, count(*) as kolvo
----from stud
----where year=1
----group by faculty
----order by kolvo desc

------9.	���������� ��������� � ����, �� ������� ������� ������� ��������� ������ 32 ���

----select faculty, year, avg(datediff(year,br_date,SYSDATETIME())) as avg_voz
----from stud
----group by faculty, year
----having avg(datediff(year,br_date,SYSDATETIME())) < 32


------10.	���������� ��������� � ���� � ����� ����������� ����� �� ������� ������ �������� �� ������ 25
select y.faculty, y.year, count(*) as kolvo
from (select * from stud) as y, (
select distinct faculty, year
from stud
where datediff(year,br_date,SYSDATETIME())>=25
) as x
where y.faculty = x.faculty and y.year= x.year
group by y.faculty, y.year

------11.	����� ��������� � ����, �� ������� ��������� ��� �������� ��������� ������ ������

--select faculty, year
--from(
--select faculty, year, count(*)as kolvo
--from stud
--where s_name is null 
--group by faculty, year
--) as x
--where kolvo>1

------12.	������� ���������� � ����� ���������� �������� ������������.

--select top 1 *
--from stud
--order by exm desc


------13.	������� ������ ���� �������� � ������������

--select distinct form
--from stud

------14.	���������� ����� ���� �������� � ������������ �� ������� ������

--select count(*) as kolvo
--from(
--select distinct form
--from stud
--) as x

------15.	���������� ����� ���� �������� �� ������ ����������
--select faculty, count(*) as kolvo
--from(
--select distinct faculty, form
--from stud
--) as x
--group by faculty
------16.	���������� ����� ���������� ����������� � ��������� �� ����������� ������� ������� ���������� �� ����� � 

--select count(*) as kolvo
 
--from stud
--where s_name is null or (last_name like '�%' and s_name is not null)


------17.	���������� ������� �������� ����������� �  ����� ��������� � ������������*

--select cast((inost) as float)/vse*100 as kolvo
--from(
--select count(*) as inost 
--from stud
--where s_name is null
--) as x,
--(select count(*) as vse 
--from stud) as y

