------������� � ������������ ������ �4

------1.	������� ���������� � ������ ���� ��������� (���������, ����) ������� ����� �������� ������ 30 ���



--select  x.* from (select top 3 * from stud
--where id = some (select stud_id from process 
--           where hours_id = some (select id from hours 
--		         where form_id = some (select id from form 
--				       where form_name = '������')))
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
--some (select id from form where form_name = '������')


select process.stud_id, faculty.faculty_name 
from hours
inner join faculty on hours.faculty_id = faculty.id
inner join process on hours.id = process.hours_id
where form_id = some (select id from form where form_name = '������')


------2.	������� ���������� � ������ ���� ��������� (���������, ����) ������� ����� �������� ������ 25 ���
------3.	���������� ���������� ��������� �� ������ ����������
------4.	���������� ���������� ���������, �������� �� ������ ����� ��������
------5.	���������� ������� ������� ��������� ��� ������� ���������� �� ����� ���� (���)
------6.	����� ���� ���������-����������� (��� ��������), ������� �������� � ��� (���� �����������, ���������, ����, ����� ��������)
------7.	���������� ����� ���������� ���������� ����� �� ���� ������ �������� ��� ��������� ������� ���
------8.	���������� ����� ���������� ����� �������� ����� ��� ��������� ������� ����� �������� ��� ������� ����� ��������
------9.	���������� ���� ����������� (� ������ ����������, �� ������ ���� ��������) �������� ������������ 
------10.	���������� �� ����� ��������� ��������� ���������� ���������� ������� � 2015 ����
------11.	������� ������ ���������, ������� ������ �� ��� ��  ������, ��� � ������� ������� � ��������� �������
------12.	������� ������ ��������� �� �����������, ������� ���� ������� ������  7
------13.	������� ������ ���������, ������� ���� ������� ������ ��� ������� �� ���������
------14.	 ������� ������ ���������, ������� ��� ������� ���� ��� �� �� ����������
