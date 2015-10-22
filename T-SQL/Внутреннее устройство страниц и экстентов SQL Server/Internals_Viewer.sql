use [Pages_and_Extents_Architecture];
go
--Internals_Viewer DEMO
alter database [Pages_and_Extents_Architecture]
add filegroup FG;
go
alter database [Pages_and_Extents_Architecture]
add file ( name = 'NewFile', filename = 'c:\temp\NewFile.ndf', size = 512 Kb ) to filegroup FG;
go
create table t (id int) on FG
insert into t
select 1
dbcc traceon(3604);
dbcc page( [Pages_and_Extents_Architecture], 3, 2, 2 )-- with tableresults;
go
dbcc page( [Pages_and_Extents_Architecture], 1, 1, 1 ) with tableresults;
dbcc page( [Pages_and_Extents_Architecture], 3, 1, 3 )
go

select * from dbo.t
  cross apply fn_PhysLocCracker(%%physloc%%);
go
insert into t
select 2
dbcc page( [Pages_and_Extents_Architecture], 3, 8, 1 )-- with tableresults;
go
delete from t
where id = 1