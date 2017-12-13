------Создать хранимую процедуру:
------ добавление нового плана нагрузки для заданного курса формы обучения и факультета:
------Входные данные : название факультета, форма, курс, количество часов общее, количество часов в классе
------Условие добавления: 
------если существует такой факультет и форма обучения, то выполнить проверку о существовании нагрузки для заданного факультета, курса, формы обучения;
------      ----Если нагрузка определена – то обновить
------      ----Если нет нагрузки – то внести новую запись
------- Если факультета или формы не существует – завершить процедуру
------Условия завершения транзакции: 
------ - eсли сумма нагрузки для всех курсов данной формы обучения заданного факультета не превышает 400 часов – транзакцию завершить, иначе - откатить транзакцию



create proc Set_New_Hours @v_faculty nvarchar(25), @v_form nvarchar(25), @v_course int, @v_allhours int, @v_classhours int
as
	declare @iv_fac int, @iv_form int, @iv_sum int
	select @iv_fac =  faculty.id from faculty where faculty_name=@v_faculty
	select @iv_form = form.id from form where form.form_name=@v_form
	begin tran
		if exists(select * from hours	where hours.faculty_id=@iv_fac and hours.form_id=@iv_form)
			if exists (select * from hours	where hours.faculty_id=@iv_fac and hours.form_id=@iv_form and hours.course=@v_course)
				begin	
					update hours
					set all_h = @v_allhours, inclass_h = @v_classhours
					where faculty_id=@iv_fac and form_id=@iv_form and course=@v_course
					select 'Hours was updated' as message
				end
			else
				begin
					insert into hours (faculty_id, form_id, course, all_h, inclass_h)
					values (@iv_fac, @iv_form, @v_course, @v_allhours, @v_classhours)
					select 'New row was inserted' as message
				end
		else 
			begin
				rollback
				select 'Can not find those faculty and form, operation aborted' as error
			end
		select @iv_sum =  SUM(all_h + inclass_h) from hours  where hours.faculty_id=@iv_fac and hours.form_id=@iv_form
		if @iv_sum > 2000  -- добавил слегка ,чтобы реально работало
			begin
				rollback
				select 'Update failed! Over 2000 hours for those faculty, form' as message
			end
		else
			begin
				commit
				select 'Update sucsessfull!' as message
			end
go

Set_New_Hours 'ФПК','заочно',3,200,400

