--using UNIVER
--7.	���������� ������� ���� �� ������� ����� �������� ������� ����������.

select faculty, avg(exm) as average_ball
from stud
where form = '�������'
group by faculty


--8.	����� �������� ������������ ������� ������ ��� ������� ���������� � �����

select faculty, year, max(exm) as max_av_ball
from stud
group by faculty, year

--9.	���������� ������ �����������, ������� ���� ������������ �� ������� ������ 7.5

select faculty, avg(exm) as average_ball
from stud
group by faculty
having avg(exm) > 6.5

--10.	���������� ������ ������ � ��������� ����������, ������� ���� ������������ �� ������� ������ 7.5

select year, faculty, avg(exm) as average_ball
from stud
group by year, faculty
having avg(exm) > 6.5

--11.	���������� ����� �������� � ��������� � ����������, ��� ������� ����������� ���� ������������ ��� ������ �� ��������� ������ 7.

select form, faculty, min(exm) as minimal_avg
from stud
group by form, faculty
having min(exm) < 7
  
--12.	 ����������, ����� ���������� ����� �������� ��� 3-�� ����� ������� ����� �������� ������ �� ��������������� ����������

select  avg(all_h - inclass_h) as inhome_h
from stud
where faculty = '���' and year = 3 and form = '�������'

--���

select  distinct (all_h - inclass_h) as inhome_h
from stud
where faculty = '���' and year = 3 and form = '�������'


--13.	������� ������ �����������, ������, ���� �������� �� ������� �������� ������ ����� 150 ����� �� ��������������� ����������

select distinct faculty, year, form 
from stud
where (all_h-inclass_h)>150


--14.	���������� ������� ����� �����, ������� ������ ������� ���������� ��� ������ ����� �������� �� ���� ���  �� ���� �����.

select faculty, form, avg(all_h) as avg_all_hours
from stud
group by faculty, form
