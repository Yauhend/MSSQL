create database warehouse;

use warehouse;

create table providers (id int auto_increment  primary key, 
							name nvarchar(50));



create table sets (
	id int auto_increment,
	id_prov int,
	date_set date,
	name nvarchar(50),
	price float(7,2),
	primary key (id),
	foreign key (id_prov) references providers(id));



create table orders (
	id int auto_increment,
	id_prov int,
	date_set date,
	name nvarchar(50),
	price float(7,2),
	date_order date,
	primary key (id),
	foreign key (id_prov) references providers(id)
);

insert into providers (name)
values ('ProdInvest'), ('KrendelProduction'),('Rodnichek');

insert into sets (id_prov, date_set, name, price)
values
(1,'2018-02-01','Овсянка',1),
(1,'2018-02-01','Гречка',1),
(2,'2018-02-01','Батон',1),
(3,'2018-02-01','Шампанское',5),
(3,'2018-02-01','Коньяк',19),
(2,'2018-02-02','Батон',1),
(2,'2018-02-02','Ватрушка',1.5),
(1,'2018-02-03','Шампанское',5),
(1,'2018-02-03','Коньяк',20);

select* from sets;

delete from sets
where id > 9;
