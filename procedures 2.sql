--Создать хранимую процедуру:
--Подсчета количества студентов на факультете и форме обучения (входные данные название факультета и наименование формы обучения )

create proc student_count @v_faculty nvarchar(10), @v_form nvarchar (15)
as 
	declare @iv_fac int, @iv_form int, @iv_sum int
	select @iv_fac =  faculty.id from faculty where faculty_name=@v_faculty
	select @iv_form = form.id from form where form.form_name=@v_form
	if exists(select * from hours	where hours.faculty_id=@iv_fac and hours.form_id=@iv_form)
		begin
			select @iv_sum = count(*) 
			from stud 
				join process on process.stud_id = stud.id
				join hours on hours.id = process.hours_id
			where hours.faculty_id = @iv_fac and hours.form_id = @iv_form
			select @iv_sum as Number_of_Students
			return
		end
	else
		begin
			select 'Can not find faculty or form' as error
			return
		end
go

student_count 'ФПК','заочно'