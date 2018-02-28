create database UNIVER2;

use UNIVER2;

Create table stud
(id int auto_increment,
last_name nvarchar(25) not null,
f_name nvarchar(25) not null,
s_name nvarchar(25) default null,
br_date date,
in_date date,   
exm float default NULL ,
CONSTRAINT PK_stud Primary key (id) 
);
insert into stud
(last_name,f_name,s_name,br_date,in_date,exm) values
(N'Стрынгель',N'К',null,'19831212','20160901',8),
(N'Козлова',N'Д',N'Е','19831012','20150901',8.4),
(N'Федоров',N'Н',N'Н','19811207','20140901',7),
(N'Рингель',N'П',N'О','19730215','20160901',8),
(N'Бежик',N'Н',N'Н','19931211','2016-09-01',4.5),
(N'Осипчик',N'Н',N'Н','19831216','20150901',7.7),
(N'Белый',N'С',N'С','19870627','20150901',6.7),
(N'Ботяновский',N'А',N'С','19870723','20150901',7.6),
(N'Слободницкий',N'С',N'А','19870803','20150901',6.7),
(N'Рогатка',N'П',N'Р','19861027','20160901',7.4),
(N'Федоренко',N'П',N'Р','19950426','20160901',5.6),
(N'Зингель',N'П',N'В','19900425','20150901',3.4),
(N'Михеенок',N'Л',N'Н','19890313','20150901',5.3),
(N'Савицкая',N'Л',N'Н','19950705','20140901',7.7),
(N'Ковальчук',N'О',N'Е','19640523','20160901',7.6),
(N'Заболотная',N'Л',N'И','19860914','20160901',4.7),
(N'Ковриго',N'И',null,'19920301', '20150901',7.7),
(N'Шарапо',N'М',null,'19970325', '20150901',8.7),
(N'Сафроненко',N'Н',N'Л','19920525','20140901',7.7),
(N'Зайцева',N'Т',N'Я','19940725','20140901',5.6);

Create table form
(id int auto_increment,
form_name nvarchar(25) not null,
CONSTRAINT PK_form Primary key (id) 
);
insert into  form (form_name) values 
(N'очно'),
(N'заочно'),
(N'вечернее');

Create table faculty
(id int auto_increment,
faculty_name nvarchar(25) not null,
CONSTRAINT PK_faculty Primary key (id) 
);

insert into faculty (faculty_name)values 
(N'ФПМ'),
(N'ФПК');

Create table hours
(id int auto_increment,
course int,
faculty_id int,
form_id int,
all_h int default NULL,
inclass_h int default NULL,  
CONSTRAINT PK_hours Primary key (id) ,
CONSTRAINT FK_to_faculty foreign key (faculty_id) references faculty(id),
CONSTRAINT FK_to_form foreign key (form_id) references form(id)
);

insert into hours (course,faculty_id,form_id,all_h,inclass_h) values 
(1,2,2,300,100),
(2,2,2,350,110),
(3,2,2,300,100),
(1,2,3,500,400),
(2,2,3,450,370),
(1,1,1,500,450),
(2,1,1,500,450),
(3,1,1,450,400),
(1,1,2,350,100),
(2,1,2,360,120),
(3,1,2,370,130),
(4,1,2,370,130);

Create table process
(stud_id int not null,
hours_id int not null,
CONSTRAINT PK_process Primary key (stud_id,hours_id) ,
CONSTRAINT FK_to_hours foreign key (hours_id) references hours(id),
CONSTRAINT FK_to_stud foreign key (stud_id) references stud(id)
);

insert into process (stud_id,hours_id) values
(1,1),
(2,2), 
(3,3),
(4,3),
(5,4),
(6,4),
(7,5),
(8,5),
(9,5),
(10,6),
(11,6),
(12,7),
(13,8),
(14,8),
(15,9),
(16,9),
(17,10),
(18,10),
(19,11),
(20,11);
