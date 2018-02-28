delimiter //

create procedure setOrders(indate_set date, inprov_name nvarchar(50), ordersize int)

begin

if ordersize is null then set ordersize =1;
end if;		


	

if inprov_name is null then
		select 'Name of provider is null' as error;
	elseif indate_set is null then set indate_set = curdate();
end if;
		
		while ordersize>0 do
			insert into orders (id_prov, date_set, name, price, date_order)
			select id_prov, date_set, sets.name, price, indate_set as date_order from sets
			join providers on sets.id_prov = providers.id
			where providers.name = inprov_name and sets.date_set = (
				select max(sets.date_set) from sets
				join providers on sets.id_prov = providers.id
				where providers.name = inprov_name);
			set ordersize = ordersize - 1;
		end while;
end//

delimiter ;
