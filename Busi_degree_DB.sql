Create table TFP_normalized
(industryID int,
populationID int,
PgrowthID int,
wageID int,
wgrowthID int)

create table TFP_content
(industryID int primary key, 
name char(10),
populationID int,
population int,
pgrowthID int,
pgrowth_percentage decimal(3,2),
wageID int,
wage decimal(8,2),
wgrowthID int,
wgrowth_percentage decimal(3,2))


create table industry_name
(industryID int,
industry_name char(10))
 
create table population
(populationID int,
population_count int)

Create table pgrowth
(pgrowthID int,
pgrowth_rate decimal(3,2))

create table wage
(wageID int, 
avrg_wage decimal(8,2))

create table wgrowth
(wgrowthID int,
wgrowth_rate decimal(3,2))

select * from TFP_normalized
select *from TFP_content
select* from industry_name
select* from population
select* from pgrowth
select* from wage
select* from wgrowth

drop table TFP_normalized
drop table TFP_content
drop table industry_name
drop table population
drop table pgrowth
drop table wage
drop table wgrowth

--Trigger 1 (tr_TFPContent_ins)
create trigger tr_TFPContent_ins
on TFP_content
after insert
as
declare @industryID int;
declare @populationID int;
declare @pgrowthID int;
declare @wageID int;
declare @wgrowthID int;
declare @industry_name char(10);
declare @population_count int;
declare @pgrowth_rate decimal(3,2);
declare @avrg_wage decimal(8,2);
declare @wgrowth_rate Decimal(3,2);

select @industryID =industryID from inserted;
select @populationID = populationID from inserted;
select @pgrowthID = pgrowthID from inserted;
select @wageID = wageID from inserted;
select @wgrowthID = wgrowthID from inserted;
insert into TFP_normalized(industryID, populationID, pgrowthID, wageID, wgrowthID)
values (@industryID, @populationID,@pgrowthID,@wageID,@wgrowthID)

select @industryID = industryID from inserted;
select @industry_name=name from inserted;
insert into industry_name(industryID, industry_name)
values (@industryID, @industry_name)

select @populationID = populationID from inserted;
select @population_count = population from inserted;
insert into population(populationID, population_count)
values (@populationID, @population_count)

select @pgrowthID = pgrowthID from inserted;
select @pgrowth_rate = pgrowth_percentage from inserted;
insert into pgrowth(pgrowthID,pgrowth_rate)
values (@pgrowthID, @pgrowth_rate)

select @wageID= wageID from inserted;
select @avrg_wage = wage from inserted;
insert into wage(wageID,avrg_wage)
values (@wageID, @avrg_wage)

select @wgrowthID= wgrowthID from inserted;
select @wgrowth_rate = wgrowth_percentage from inserted;
insert into wgrowth(wgrowthID, wgrowth_rate)
values (@wgrowthID,@wgrowth_rate)
go

drop trigger tr_TFPContent_ins

insert into TFP_content
values
('1','Consulting','1','623694','1','7.26','1','103086.76','1','3.04')

insert into TFP_content
values
('2','Accounting','2','552177','2','9.74','2','83612.74','2','3.72')

insert into TFP_content 
values
('3','Insurance','3','513397','3','4.70','3','72359.05','3','2.49')
insert into TFP_content 
values
('4','Banking','4','429999','4','3.79','4','97428.55','4','3.60')
insert into TFP_content
values
('5','Investing','5','409456','5','6.45','5','144152.55','5','3.97')

delete from TFP_content
where industryID=5



update industry_name
set industry_name = 'Consulting'
where industryID ='1'

--Trigger 2(del_TFP_Content)
create table del_TFP_content
(industryID int primary key, 
name char(10),
populationID int,
population int,
pgrowthID int,
pgrowth_percentage decimal(3,2),
wageID int,
wage decimal(8,2),
wgrowthID int,
wgrowth_percentage decimal(3,2))

create trigger tr_TFPcontent_del
on TFP_content
after delete
as 
insert into del_TFP_content
select * from deleted

--stored Procedure 1 (wage lookup)
create procedure wage_lookup(
@industryID int)
as
select TFP_content.industryid, name, wage, wgrowth_percentage
from TFP_content
inner join industry_name
on TFP_content.name= industry_name.industry_name
inner join wage
on TFP_content.wage= wage.avrg_wage
inner join wgrowth
on TFP_content.wgrowth_percentage = wgrowth.wgrowth_rate
where TFP_content.IndustryID= @industryID

drop procedure wage_lookup 
exec wage_lookup 5

--stored Procedure 2 (popularity lookup)
create procedure popularity_lookup(
@populationID int)
as
select TFP_content.populationid, name, population, pgrowth_percentage
from TFP_content
inner join industry_name
on TFP_content.name= industry_name.industry_name
inner join population
on TFP_content.population= population.Population_count
inner join pgrowth
on TFP_content.pgrowth_percentage = pgrowth.pgrowth_rate
where TFP_content.populationID= @populationID

drop procedure wage_lookup 
exec popularity_lookup 5

--View 1 (view all wage)
create view v_all_wage
as
select name, wage, wgrowth_percentage
from TFP_content
inner join industry_name
on TFP_content.name= industry_name.industry_name
inner join wage
on TFP_content.wage= wage.avrg_wage
inner join wgrowth
on TFP_content.wgrowth_percentage = wgrowth.wgrowth_rate

select* from v_all_wage

--view 2 (view all population)
create view v_all_population
as
select name, population, pgrowth_percentage
from TFP_content
inner join industry_name
on TFP_content.name= industry_name.industry_name
inner join population
on TFP_content.population= population.Population_count
inner join pgrowth
on TFP_content.pgrowth_percentage = pgrowth.pgrowth_rate

select * from v_all_population
