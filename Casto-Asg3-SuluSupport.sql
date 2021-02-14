use master;
go

drop database if exists CastoAsg3SuluSupport;
go

create database CastoAsg3SuluSupport;
go

use CastoAsg3SuluSupport;
go

--tables, I enjoy scripting them more than using the GUI
create table StatusType (
	ID int primary key identity,
	[Description] varchar(25)
	);
create table OperatingSystemType (
	ID int primary key identity,
	[Description] varchar(25)
	);
	create table SupportRep (
	ID int primary key identity,
	FirstName varchar(35),
	LastName varchar(50),
	Email varchar(100),
	StatusTypeID int not null references StatusType (ID)
	);
create table Customer (
	ID int Primary Key Identity,
	SupportRepID int not null references SupportRep(ID),
	FirstName varchar(50) not null,
	LastName varchar(55) not null,
	[Address] varchar(110) not null,
	Phone varchar(15) not null,
	Email varchar(100) not null,
	DateUpdated datetime2(7) default getdate(),
	StatusTypeID int not null references StatusType(ID)
	);
create table Incident (
	ID int Primary Key Identity,
	CustomerID int not null references Customer (ID),
	SupportRepID int not null references SupportRep (ID),
	OperatingSystemTypeID int not null references OperatingSystemType (ID),
	DateAdded datetime2(7) default getdate(),
	Problem varchar(6000) not null,
	Resolution varchar(2000) not null,
	DateUpdated datetime2(7) default getdate(),
	StatusTypeID int not null references StatusType (ID)
	);

--inserting data
insert into StatusType(Description)
	values ('Active'),('Resolved'),('Inactive'),('Deleted');
go
insert into OperatingSystemType(Description)
	values ('XP'),('Vista'),('Windows 8'),('Windows 10'),('OSX'),('Other');
go
insert into SupportRep
	values ('John','Smith','JSmith@ymail.com', 1)
go
insert into Customer
	values (1,'Sterling','Archer','Classified','3045678900','SArcher@ymail.com',getdate(),1),
			(1,'Jane','Doe','456 Main St', '3041234567','JDoe@ymail.com',getdate(),1),
			(1,'Tom','Shoesmith','120 Dublin St','2089324567','TShoesmith@ymail.com',getdate(),1);
go
insert into Incident
	values (1,1,6,getdate(),'Unable to balance operating account','Russian mole siphoned funds out of operating account',getdate(),2),
			(1,1,6,getdate(),'Computer will not turn on','Plugged in computer which fixed the issue',getdate(),2),
			(2,1,4,getdate(),'Does not agree with the use of Cortana. Says she really screwed over some chief or master','Not sure there were any issues with the computer',getdate(),1);
go

--select statement to show the two incident for the one customer
select c.ID as 'CustomerID', c.FirstName,c.LastName, stCustomer.Description as 'CustomerStatus',i.ID as 'IncidentID', i.Problem,
	   i.Resolution, os.Description, sr.FirstName + ' ' + sr.LastName as 'SupportRep', stIncident.Description as 'IncidentStatus'
from Customer c
	join SupportRep sr on c.SupportRepID = sr.ID
	join StatusType stCustomer on c.StatusTypeID = stCustomer.ID
	join Incident i on c.ID = i.CustomerID
	join OperatingSystemType os on i.OperatingSystemTypeID = os.ID
	join StatusType stIncident on i.StatusTypeID = stIncident.ID



select * from OperatingSystemType
select * from SupportRep
select * from StatusType
select * from Customer
select * from Incident







