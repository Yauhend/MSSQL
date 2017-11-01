------������� � ������������ ������ �4

------1.	������� ���������� � ������ ���� ��������� (���������, ����) ������� ����� �������� ������ 30 ���

select top 3 stud.*, faculty.faculty_name, hours.course from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = '������' and DATEDIFF ( YEAR , stud.br_date, SYSDATETIME()) < 30

------2.	������� ���������� � ������ ���� ��������� (���������, ����) ������� ����� �������� ������ 25 ���

select top 5 stud.*, faculty.faculty_name, hours.course from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = '������' and DATEDIFF ( YEAR , stud.br_date, SYSDATETIME()) >= 25

------3.	���������� ���������� ��������� �� ������ ����������
select COUNT(*) as Chislo_studentov, faculty.faculty_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty_name

 ------��� ���� ����� ���

select COUNT(*) as Chislo_studentov, faculty.faculty_name from process 
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty_name

------4.	���������� ���������� ���������, �������� �� ������ ����� ��������

select COUNT(*) as Chislo_studentov, form.form_name from process 
join hours on process.hours_id = hours.id
join form on hours.form_id = form.id
group by form.form_name

------5.	���������� ������� ������� ��������� ��� ������� ���������� �� ����� ���� (���)

select avg(DATEDIFF ( YEAR , stud.br_date, '2017-12-31')) as sr_vozrast, faculty.faculty_name  from stud
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty.faculty_name


--------6.	����� ���� ���������-����������� (��� ��������), ������� �������� � ��� (���� �����������, ���������, ����, ����� ��������)

select  stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where stud.s_name is null

------7.	���������� ����� ���������� ���������� ����� �� ���� ������ �������� ��� ��������� ������� ���

select sum(hours.inclass_h) as summa_chasov from hours 
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = '����' and faculty.faculty_name ='���'

------8.	���������� ����� ���������� ����� �������� ����� ��� ��������� ������� ����� �������� ��� ������� ����� ��������

select sum(hours.all_h) as summa_chasov from hours 
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = '������' and faculty.faculty_name ='���'

------9.	���������� ���� ����������� (� ������ ����������, �� ������ ���� ��������) �������� ������������ 

select stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where faculty.id =  -- ����� �� ����� �� ���� ������, ����� ���� ��������� any � ������ ��� 1
	(select top 1 hours.faculty_id from stud 
	join process on stud.id = process.stud_id
	join hours on process.hours_id = hours.id
	where stud.last_name = '�����������')
and stud.last_name <> '�����������'

------10.	���������� �� ����� ��������� ��������� ���������� ���������� ������� � 2015 ����

select top 1 faculty.faculty_name, COUNT (process.stud_id) as kol_post_v_2015 from stud
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
where stud.in_date like '2015%'
group by faculty.faculty_name

------11.	������� ������ ���������, ������� ������ �� ��� ��  ������, ��� � ������� ������� � ��������� �������

select stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where hours.course = any --��� ����� ������
	(select  hours.course from stud 
	join process on stud.id = process.stud_id
	join hours on process.hours_id = hours.id
	where stud.last_name = '�������' or stud.last_name = '�������')


------12.	������� ������ ��������� �� �����������, ������� ���� ������� ������  7

select  faculty.faculty_name, stud.* from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where stud.exm < 7
order by faculty.faculty_name, stud.exm desc

------13.	������� ������ ���������, ������� ���� ������� ������ ��� ������� �� ���������

--���, ��������, ����� ��������� ��� �� ������� �������������� �������))
select  * from stud 
where exm < (select AVG(exm) from stud)
order by exm desc

------14.	 ������� ������ ���������, ������� ��� ������� ���� ��� �� �� ����������
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

---- ��� �������� �������� �������� ����� �� �����������
select AVG(exm), faculty.faculty_name from stud
				join process on stud.id = process.stud_id
				join hours on process.hours_id = hours.id
				join faculty on hours.faculty_id = faculty.id
				group by faculty.faculty_name