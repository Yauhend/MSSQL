--use UNIVER;
--1.	������� ���������� � ���������, ������� �� ����� �������� ���� �� �����������   31 ����

--select * from stud
--WHERE DATEDIFF ( YEAR , br_date, '2017-12-31')<31

----2.	������� ������� ������� ��������� �� ����������, ����� � ����� ��������

--select  faculty, year, form, avg(DATEDIFF ( YEAR , br_date, SYSDATETIME())) as avg_years
--from stud
--group by faculty, year, form

--3.	������� ���������� � ���������, ������� �� ������� ������ ���������� 31 ���

--select * from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME())>=31

--4.	����� ����������  ��������� �� 32 �� 45 ���

--select COUNT (*) 
--from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME()) between 32 and 45


--5.	���������� ������� ��������� ������ 45 ��� ������ �� ������ ���������� �� ������ �����

--select  faculty, year,  COUNT (*) 
--from stud
--WHERE DATEDIFF ( YEAR , br_date, SYSDATETIME()) >= 45
--group by faculty, year 


--6.	��������� ���������,  �� ������� ������ ������������ ���������� ��������� �� 35


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
 





--7.	���������� ��������� � ����������� ������ ��������� �� ������� ����� ��������

--select top 1 faculty, count(*) as kolvo
--from stud
--WHERE form = '�������'
--group by faculty
--order by  kolvo asc 


--8.	���������� ���������, �� ������� ������ ������������ ����� �������������� ������� ��� ���������

-- select top 1 faculty, count(*) as kolvo
--from stud
--WHERE year = 1 and (form ='�����' or form='�������')
--group by faculty
--order by  kolvo desc 

--9.	���������� ��������� � ����, �� ������� ������� ������� ��������� ������ 32 ���

--select  faculty, year
--from stud
--group by faculty, year
--having avg(DATEDIFF ( YEAR , br_date, SYSDATETIME()))<32


--10.	���������� ��������� � ���� � ����� ����������� ����� �� ������� ������ �������� �� ������ 25





--11.	����� ��������� � ����, �� ������� ��������� ��� �������� ��������� ������ ������
--select  faculty, year, kolvo 
--from(
--select  faculty, year, COUNT(*) as kolvo
--from stud
--where s_name is NULL
--group by faculty, year) as s --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--where kolvo>=2


--12.	������� ���������� � ����� ���������� �������� ������������.
--select * from stud
--where exm = (select  MAX(exm) from stud)

--13.	������� ������ ���� �������� � ������������

--select  distinct form from stud

--14.	���������� ����� ���� �������� � ������������ �� ������� ������

--select COUNT(distinct form) from stud

--15.	���������� ����� ���� �������� �� ������ ����������

--select faculty, COUNT(distinct form) from stud
--group by faculty


--16.	���������� ����� ���������� ����������� � ��������� �� ����������� ������� ������� ���������� �� ����� � 



--17.	���������� ������� �������� ����������� �  ����� ��������� � ������������*
