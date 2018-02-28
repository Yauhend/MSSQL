
delimiter $
create trigger tr3 before delete on stud
for each row
begin
delete from process where stud_id = old.id;
insert into arch_stud (last_name, f_name, s_name, br_date, in_date, exm)
 values (old.last_name, old.f_name, old.s_name, old.br_date, old.in_date, old.exm);
end$
delimiter ;