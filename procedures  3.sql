----Создать хранимую процедуру: добавления студента на указанный факультет и форму обучения 
----(входные данные название факультета и наименование формы обучения, дата рождения дата поступления  )

create proc student_add @v_faculty nvarchar(10), @v_form nvarchar (15), @v_birthdate date, @v_indate date
as 
	declare @iv_fac int, @iv_form int
	select @iv_fac =  faculty.id from faculty where faculty_name=@v_faculty
	select @iv_form = form.id from form where form.form_name=@v_form
	if exists(select * from hours	where hours.faculty_id=@iv_fac and hours.form_id=@iv_form and hours.course = 1)
		begin
			begin tran
				insert into stud(last_name, f_name, br_date, in_date)
				values ('!Blank', '!Blank', @v_birthdate, @v_indate)
				insert into process(stud_id,hours_id)
				values ((select top 1 id from stud order by id desc), (select top 1 id from hours	where hours.faculty_id=@iv_fac and hours.form_id=@iv_form and hours.course = 1))
			commit
			select 'New student added' as message
			return
		end
	else
		begin
			select 'Can not find 1st course on this faculty and form' as error
			return
		end
go


student_add 'ФПК','заочно', '1983-12-12', '2016-12-12' 

