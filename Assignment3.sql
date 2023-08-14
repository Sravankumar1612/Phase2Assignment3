create database ExDb on primary
(NAME='Ex_Db' ,FILENAME='E:\Dotnet\Phase2\Day3\Ex_Db.mdf')
LOG ON
(NAME='Ex_log', FILENAME='E:\Dotnet\Phase2\Day3\Ex_log.ldf')
COLLATE SQL_Latin1_General_CP1_CI_AS

use ExDb

create table CompanyInfo(
Cid int primary key,
CName nvarchar(20))

insert into CompanyInfo values(1,'Samsung'),(2,'HP'),(3,'Apple'),(4,'Dell'),(5,'Toshiba'),(6,'Redmi')

create table ProductInfo(
Pid int primary key,
PName nvarchar(20) not null,
PPrice float,PMdate date not null,
CInfo int foreign key references CompanyInfo)

insert into ProductInfo values(101,'Laptop',55000.90,'12/12/2023',1)
insert into ProductInfo values(102,'Laptop',35000.90,'12/12/2023',2)
insert into ProductInfo values(103,'Mobile',15000.90,'12/03/2023',2),
								(104,'Laptop',135000.90,'12/12/2012',3),
								(105,'Mobile',65000.90,'12/12/2012',3),
								(106,'Laptop',35000.90,'12/12/2012',5),
								(107,'Mobile',35000.90,'12/01/2012',5),
								(108,'EarPod',1000.90,'12/01/2022',3),
								(109,'Laptop',85000.90,'12/12/2021',6),
								(110,'Mobile',55000.90,'12/12/2020',1)
--All company names and Product info
select c.CName,p.PName from ProductInfo p
right outer join CompanyInfo c on c.Cid=p.CInfo

--All Product names and respective Company
select p.PName,c.CName from ProductInfo p
left outer join CompanyInfo c on c.Cid=p.CInfo

--All possible combinations
select * from ProductInfo p
cross join CompanyInfo c
---------------------------------------------------------------------------------

--------Part2---------

create table Products(
PId int primary key,
PQ int not null,
PPrice float,
Discount float)

INSERT INTO Products VALUES(1, 2, 900,0.05),(2, 3, 490,0.15),(3, 3, 700, 0.1)

create function Discounts(
@price float,@dis_percentage float)
returns float
as 
begin
declare @discount float
begin
select @discount=@price*@dis_percentage
end
return @discount
end

select p.PId,p.PPrice,p.Discount,p.PPrice-dbo.Discounts(PPrice,Discount) as 'Price after Discount' 
from Products p