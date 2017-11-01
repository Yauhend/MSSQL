------Çàäàíèå ê ëàáîðàòîðíîé ðàáîòå ¹4


------1.	Âûâåñòè èíôîðìàöèþ î ïåðâûõ òðåõ ñòóäåíòàõ (ôàêóëüòåò, êóðñ) çàî÷íîé ôîðìû îáó÷åíèÿ ìëàäøå 30 ëåò

select top 3 stud.*, faculty.faculty_name, hours.course from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'çàî÷íî' and DATEDIFF ( YEAR , stud.br_date, SYSDATETIME()) < 30

------2.	Âûâåñòè èíôîðìàöèþ î ïåðâûõ ïÿòè ñòóäåíòàõ (ôàêóëüòåò, êóðñ) çàî÷íîé ôîðìû îáó÷åíèÿ ñòàðøå 25 ëåò

select top 5 stud.*, faculty.faculty_name, hours.course from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'çàî÷íî' and DATEDIFF ( YEAR , stud.br_date, SYSDATETIME()) >= 25

------3.	Îïðåäåëèòü êîëè÷åñòâî ñòóäåíòîâ íà êàæäîì ôàêóëüòåòå
select COUNT(*) as Chislo_studentov, faculty.faculty_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty_name

 ------èëè äàæå ëó÷øå òàê

select COUNT(*) as Chislo_studentov, faculty.faculty_name from process 
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty_name

------4.	Îïðåäåëèòü êîëè÷åñòâî ñòóäåíòîâ, ó÷àùèõñÿ íà êàæäîé ôîðìå îáó÷åíèÿ

select COUNT(*) as Chislo_studentov, form.form_name from process 
join hours on process.hours_id = hours.id
join form on hours.form_id = form.id
group by form.form_name

------5.	Îïðåäåëèòü ñðåäíèé âîçðàñò ñòóäåíòîâ äëÿ êàæäîãî ôàêóëüòåòà íà êîíåö ãîäà (ëåò)

select avg(DATEDIFF ( YEAR , stud.br_date, '2017-12-31')) as sr_vozrast, faculty.faculty_name  from stud
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
group by faculty.faculty_name


--------6.	Íàéòè âñåõ ñòóäåíòîâ-èíîñòðàíöåâ (áåç îò÷åñòâà), âûâåñòè ñâåäåíèÿ î íèõ (äàòà ïîñòóïëåíèÿ, ôàêóëüòåò, êóðñ, ôîðìà îáó÷åíèÿ)

select  stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where stud.s_name is null

------7.	Îïðåäåëèòü îáùåå êîëè÷åñòâî àóäèòîðíûõ ÷àñîâ çà âåñü ïåðèîä îáó÷åíèÿ äëÿ ñòóäåíòîâ î÷íèêîâ ÔÏÌ

select sum(hours.inclass_h) as summa_chasov from hours 
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'î÷íî' and faculty.faculty_name ='ÔÏÌ'

------8.	Îïðåäåëèòü îáùåå êîëè÷åñòâî ÷àñîâ ñîãëàñíî ïëàíó äëÿ ñòóäåíòîâ çàî÷íîé ôîðìû îáó÷åíèÿ ÔÏÊ çàî÷íîé ôîðìû îáó÷åíèÿ

select sum(hours.all_h) as summa_chasov from hours 
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where form.form_name = 'çàî÷íî' and faculty.faculty_name ='ÔÏÊ'

------9.	Îïðåäåëèòü âñåõ ñîêóðñíèêîâ (ñ ó÷åòîì ôàêóëüòåòà, íî ðàçíûõ ôîðì îáó÷åíèÿ) ñòóäåíòà Áîòÿíîâñêîãî 

select stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where faculty.id =  -- âäðóã îí ñðàçó íà äâóõ ó÷èòñÿ, òîãäà ñþäà ïîñòàâèòü any è óáðàòü òîï 1
	(select top 1 hours.faculty_id from stud 
	join process on stud.id = process.stud_id
	join hours on process.hours_id = hours.id
	where stud.last_name = 'Áîòÿíîâñêèé')
and stud.last_name <> 'Áîòÿíîâñêèé'

------10.	Îïðåäåëèòü íà êàêîé ôàêóëüòåò ïîñòóïèëî íàèáîëüøåå êîëè÷åñòâî ÷åëîâåê â 2015 ãîäó

select top 1 faculty.faculty_name, COUNT (process.stud_id) as kol_post_v_2015 from stud
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
where stud.in_date like '2015%'
group by faculty.faculty_name

------11.	Âûâåñòè ñïèñîê ñòóäåíòîâ, êîòîðûå ó÷àòñÿ íà òåõ æå  êóðñàõ, ÷òî è ñòóäåíò Çèíãåëü è ñòóäåíòêà Çàéöåâà

select stud.id, stud.last_name, stud.f_name, stud.in_date, faculty.faculty_name, hours.course, form.form_name from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where hours.course = any --âîò òàêîé ñëó÷àé
	(select  hours.course from stud 
	join process on stud.id = process.stud_id
	join hours on process.hours_id = hours.id
	where stud.last_name = 'çèíãåëü' or stud.last_name = 'çàéöåâà')


------12.	Âûâåñòè ñïèñîê ñòóäåíòîâ ïî ôàêóëüòåòàì, ñðåäíèé áàëë êîòîðûõ ìåíüøå  7

select  faculty.faculty_name, stud.* from stud 
join process on stud.id = process.stud_id
join hours on process.hours_id = hours.id
join faculty on hours.faculty_id = faculty.id
join form on hours.form_id = form.id
where stud.exm < 7
order by faculty.faculty_name, stud.exm desc

------13.	Âûâåñòè ñïèñîê ñòóäåíòîâ, ñðåäíèé áàëë êîòîðûõ ìåíüøå ÷åì ñðåäíèé ïî èíñòèòóòó

--òóò, íàâåðíîå, ñòîèò óñëîæíèòü èëè ïî äðóãîìó ñôîðìóëèðîâàòü çàäàíèå))
select  * from stud 
where exm < (select AVG(exm) from stud)
order by exm desc

------14.	 Âûâåñòè ñïèñîê ñòóäåíòîâ, ñðåäíèé áàë êîòîðûõ âûøå ÷åì ïî èõ ôàêóëüòåòó
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

---- äëÿ ïðîâåðêè çíà÷åíèÿ ñðåäíåãî áàëëà ïî ôàêóëüòåòàì
select AVG(exm), faculty.faculty_name from stud
				join process on stud.id = process.stud_id
				join hours on process.hours_id = hours.id
				join faculty on hours.faculty_id = faculty.id
				group by faculty.faculty_name
