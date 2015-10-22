use [Pages_and_Extents_Architecture];
go
--Extents DEMO
if object_id ( N'dbo.extent_demo', N'U' ) is not null
drop table dbo.extent_demo;
go
create table dbo.extent_demo ( id int identity primary key
                             , val varchar(8000) default replicate( 'A', 8000 ) 
                             );
go
insert into dbo.extent_demo
default values;
go 8

dbcc traceon(3604);
go
dbcc extentinfo( [Pages_and_Extents_Architecture], 'dbo.extent_demo', -1 ); 
go