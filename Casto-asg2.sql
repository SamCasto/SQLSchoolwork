-- 2-1
Use master
go

drop database if exists MyWebDb
go

create database MyWebDb
go

use MyWebDb
go

create table [User] (
	"ID" int Primary Key Identity,
	"FirstName" varchar(25) not null,
	"LastName" varchar(25) not null,
	"EmailAddress" varchar(50) not null
	);
create table Product (
	"ID" int primary key identity,
	"ProductName" varchar(55) not null
	);
create table Download (
	"ID" int primary key identity,
	"UserID" int not null references [User] (ID),
	"ProductID" int not null references Product (ID),
	"FileName" varchar(55) not null,
	"DownloadDate" datetime2(7)
	);
-- 2-2
use MyWebDb
go
insert into [User]
values ('John','Smith','JSmith@ymail.com'),
		('Jane','Doe','JDoe@ymail.com');
insert into "Product"
values ('Local Music Vol 8'),
		('Local Music Vol 3');
insert into "Download"
values (1,2,'More_than_my_hometown.exe', getdate()),
	(2,1,'Down_to_the_honkeytonk.mp3', getdate()),
	(2,2,'1_2_Many.mp3',getdate());
select EmailAddress, FirstName, LastName, d.DownloadDate, d.FileName, p.ProductName
	from Download d
	join [User] u on d.UserID = u.ID
	join Product p on d.ProductID = p.ID
	order by u.EmailAddress desc, p.ProductName asc


-- 2-3
use MyWebDb
go

alter table Product
	Add "ProductPrice" decimal(5,2) default 9.99,
		"DateAdded" datetime not null default getdate();
alter table [User]
	alter column "FirstName" varchar(20) not null;

-- 2-4
use MyWebDb
go

update [User] 
	set "FirstName" = null
	where ID = 1;
update [User]
	set "FirstName" = 'Viacheslav Vasilyevich Ragozin'
	where ID = 1;