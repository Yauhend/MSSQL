
delimiter $
create trigger tr2 before delete on form
for each row
begin
delete from process where hours_id in
			(select id from hours
            where form_id = old.id);
delete from hours where form_id = old.id;
end$
delimiter ;