-- 3/5/2021
-- Samuel Casto
-- Script to create Rental Table for SlumLordRentals Database.
-- Note Database must exists before running the script.
use master
go

drop database if exists [SlumLordRentalsCasto]
go

create database [SlumLordRentalsCasto]
go

USE [SlumLordRentalsCasto]
GO

/****** Object:  Table [dbo].[Rental]    Script Date: 2/21/2018 11:18:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- New syntax in SQL Server 2016... Who would have thunk it?
drop  table if exists Rental

CREATE TABLE [dbo].[Rental](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](25) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](10) NULL,
	[Price] [money] NULL,
	[Description] [varchar](5000) NULL,
	[StatusTypeID] [tinyint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NULL,
 CONSTRAINT [PK_Rental] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Rental] ADD  CONSTRAINT [DF_Rental_StatusTypeID]  DEFAULT ((1)) FOR [StatusTypeID]
GO

ALTER TABLE [dbo].[Rental] ADD  CONSTRAINT [DF_Rental_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

-- Add some sample data

Insert into Rental
 ([Address],[City],[State],[Zip],[Price],[Description],[StatusTypeID])
  values 
    ( '1062 Tamarack Pl','New Richmond','WI', 54017 ,1295,'2 beds 1.5 baths 1,272 sqft. One level living at it''s best. This attractive home features 2 bedrooms, 2 baths, all appliances, and a gas fireplace. Let''s see this home today! ', 1)

Insert into Rental
 ([Address],[City],[State],[Zip],[Price],[Description],[StatusTypeID])
  values 
	('1600 Pennsylvania Ave NW', 'Washington','DC',20006,397817836
     ,'Home to every American president except George Washington - who chose the site - the White House is rich in history and tradition. Known as "The People''s House", the complex is made up of the Executive Residence flanked by colonnades that connect to the West Wing and East Wing. The six-story Executive Residence serves as the president''s living quarters and entertaining area. Notable rooms include the Diplomatic Reception Room where President Franklin D. Roosevelt held fireside chats, Lincoln Bedroom that was once the namesake''s office, East Room which hosts large ceremonies and State Dining Room for formal dinners. The impressive kitchen is equipped to serve dinner for up to 140 guests and hors d''oeuvres to over 1,000. The First Family enjoys the top two floors as its private living area. These floors are altered to accommodate the needs of each new president. In addition to many bedrooms, you''ll find a sun room, music room, game room and gym. Also within the house is a library, a doctor''s office, flower and carpenter shops, and a bowling alley. Head to the East Wing, past the 40-seat Family Theater to the offices of the First Lady, the White House social secretary and correspondence staff. On the opposite side of the Executive Residence is the West Wing. This is the operations hub of the president''s top staff, complete with the press briefing room and the famous Oval Office. The complex sits on 18 meticulously landscaped acres, including the North and South Lawns, a putting green, two fountains, the Rose Garden and Jacqueline Kennedy Garden. While public White House tours are limited, anyone can appreciate the beauty of the grounds from the bordering streets.'
     ,1)

Insert into Rental
 ([Address],[City],[State],[Zip],[Price],[Description],[StatusTypeID])
  values 
	('101 Wall Str #18','New York','NY',10005,59980000
     ,'6 beds 5 baths 3,074 sqft, MASSIVE FULL FLOOR 6BDR/ 5BTH CONDO HOME...This stunning 3,074sf, never lived-in residence, occupies the whole 18th floor with luminant light through a wall of windows facing North and East. Enjoy sunsets from the corner 34'' long living space with dining alcove and views of the East River and Brooklyn. 
The interiors were gracefully designed by internationally recognized Dutch designer Piet Boon and showcases his talent of blending timeless design through the use of durable and rich… '
     ,1)

-- Just to see the data


-- Data from:  https://www.zillow.com/new-richmond-wi/rentals/

drop table if exists StatusType
go

create table StatusType(
	[ID] tinyint primary key,
	[Description] varchar(20));
go

insert into StatusType
	(ID,Description)
	values 
	(1,'Active'),(2,'Deleted')
go

--CRUD procedure spRentalInsert
create proc spRentalInsert
	@Address varchar(55), @City varchar(25), @State varchar(2), @Zip varchar(10), @Description varchar(5000), @Price money
as
insert into Rental
	([Address],[City],[State],[Zip],[Price],[Description])
	values
	(@Address, @City, @State, @Zip, @Price, @Description)
go
--inserting data with our stored procedure
exec spRentalInsert '123 Main St', 'Charleston', 'WV', 25301, '2 bed 2 bath apartment in a wonderful complex with paper thin walls', 1200;
exec spRentalInsert '124 Main St', 'Saint Albans','WV',25177,'Quaint two story 3 bed 2 bath', 125000;
exec spRentalInsert '22 Penn Dr', 'Charleston','WV',25303,'Beautiful ranch style outside the city 2 bed 1.5 bath', 120000;
exec spRentalInsert '789 Bigley Ave','Charleston','WV',25305,'Farmhouse right along the elk river 4 bed 3 bath', 245000;
exec spRentalInsert '443 Horseshoe Ln','Huntington','WV',25701,'Wonderful townhouse right down the road from Marshall University 3 bed 1.5 bath', 220000;
exec spRentalInsert '324 Whitehouse Rd','Charleston','WV',25302,'Garage and loft for rent',850;
exec spRentalInsert '912 Copperhead Dr','Saint Albans','WV',25177,'Single story with basement, 2 bed 1.5 bath',145000;
exec spRentalInsert '31 Tornado Creek Ln','Saint Albans','WV',25177,'Fixer upper on a great plot of land. Golf and fish nearby. Currently 3 bed 2.5 bath',130000;
go

--CRUD spRentallUpdate
create proc spRentallUpdate
	@ID int, @Address varchar(55), @City varchar(25), @State varchar(2), @Zip varchar(10),
	@Description varchar(5000), @Price money, @StatusTypeID int
as
update Rental
set Address = @Address, City = @City, State = @State, Zip = @Zip,Price = @Price, Description = @Description,
	StatusTypeID = @StatusTypeID, DateUpdated = getdate()
where ID = @ID
go

exec spRentallUpdate 4, '125 Main St', 'Charleston', 'WV', 25301, '2 bed 2 bath apartment in a wonderful complex with paper thin walls', 1200, 2;
exec spRentallUpdate 8,'443 Horseshoe Ln','Huntington','WV',25705,'Wonderful townhouse right down the road from Marshall University 3 bed 1.5 bath', 220000, 2;
exec spRentallUpdate 9,'324 Whitehouse Rd','Charleston','WV',25304,'Garage and loft for rent with 1.5 bath. Two car garage',750,1;
go

--CRUD spRentalChangeStatus updating rental status to a different status type as a way to 'delete' records
create proc spRentalChangeStatus
	@ID int, @StatusTypeID int
as
update Rental
set DateUpdated = getdate(), StatusTypeID = @StatusTypeID
where ID = @ID
go

exec spRentalChangeStatus 1, 2;
exec spRentalChangeStatus 6, 2;
go

--CRUD spRentalList, returning items from the rental table based on their status type and when given no parameters return all active rentals
create proc spRentalList
	@StatusTypeID int = null
as
if @StatusTypeID is null
	select @StatusTypeID = 1;
select r.ID, r.DateCreated, r.DateUpdated, st.Description as 'RentalStatus', r.Price, r.Address, r.City, r.State, r.Zip, r.Description
from Rental r
	join StatusType st on r.StatusTypeID = st.ID
where StatusTypeID = @StatusTypeID
order by r.ID desc
go

exec spRentalList 
exec spRentalList 2
go


