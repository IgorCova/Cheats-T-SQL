use [Pages_and_Extents_Architecture];
go

if object_id ( N'dbo.demo_01', N'U' ) is not null
drop table dbo.demo_01;
go
create table dbo.demo_01 ( a  int
                         , b  int
                         , c  int
                         , d  varchar(4000) default replicate( 'A', 4000 )
                         );
go

create clustered index ix_a on dbo.demo_01 (a);
go

create nonclustered index ix_b on dbo.demo_01 (b) include (d);
go

insert into dbo.demo_01 (a,b,c)
values ( 1, 11, 111 )
     , ( 1, 22, 222 )
     , ( 1, 33, 333 )
     , ( 1, 44, 444 )
     , ( 1, 55, 555 );

dbcc ind ( [Pages_and_Extents_Architecture], 'dbo.demo_01', -1 );
go
dbcc traceon(3604);
go
dbcc page([Pages_and_Extents_Architecture], 1, 203, 5) with tableresults;
go
dbcc page([Pages_and_Extents_Architecture], 1, 79, 3) with tableresults;
go
dbcc page([Pages_and_Extents_Architecture], 1, 205, 5) with tableresults;
go
dbcc page([Pages_and_Extents_Architecture], 1, 201, 5) with tableresults;
go

-------------------------------------------------------------------------

/*
--http://www.sql.ru/forum/1018674/vopros-k-ekspertam-po-indeksam
Коллеги, подскажите как ведёт себя сервер, 
если кластерный индекс состоит из 5 полей и мы создаём некластерный индекс из 6 полей, 3 из которых дублируют поля кластерного индекса, 
если брать за основу утверждение того, что некластерный включает в себя поля кластерного индекса и при этом даёт возможность "дублировать" 
эти поля в некластерном? 
*/


if object_id ( N'dbo.demo_02', N'U' ) is not null
drop table dbo.demo_02;
go
create table dbo.demo_02 ( a int not null, b int not null, c int not null, d int not null, e int not null);
go
create unique clustered index cl_xxx on dbo.demo_02 (b, d, c);
go
create nonclustered index ncl_xxx on dbo.demo_02 (d, e, a, b);
go

declare @i int = 0;
while @i < 1000
begin
insert into dbo.demo_02
values( @i,@i,@i,@i,@i );
set @i += 1
end
go 


dbcc ind ( [Pages_and_Extents_Architecture], 'dbo.demo_02', -1 );
go
dbcc traceon (3604);
go
--Кластерный не листовой уровень
dbcc page ( [Pages_and_Extents_Architecture], 1, 213, 5 ) with tableresults;
go
--НеКластерный не листовой уровень
dbcc page ( [Pages_and_Extents_Architecture], 1, 215, 5 ) with tableresults;
go


------------------------------------------------------------------------

/*
--http://www.sql.ru/forum/1089915/pomenyat-nullability-stolbca

Всем добрый день!
вопрос. Сейчас делаю перенос данных в SQL Server из Access, и все столбцы там NULL. 
После переноса планируется сделать некоторые столбцы обязательными, т.е. NOT NULL, после того, как работники занесут все данные.

Вопрос такой. Какие изменения произойдут при изменении c NULL на NOT NULL? В "SQL Server 2008 Internals" я прочитал:
"Some changes to a table’s structure require that the data be examined but not modified. For example, 
when you change the nullability property to disallow NULLs, 
SQL Server must first make sure there are no NULLs in the existing rows."

Не будут ли таких сюрпризов, как при изменении длины?
"Another negative side effect of altering tables happens when a column is altered to increase its length. 
In this case, the old column is not actually replaced. Rather, a new column is added to the table, 
and DBCC PAGE shows you that the old data is still there."

Просто данных очень много, и хотелось бы знать точно, 
какие именно изменения произойдут при изменении NULLability столбца.
Заранее спасибо! 

*/

if object_id ( N'dbo.demo_03', N'U' ) is not null
drop table dbo.demo_03;
go
create table dbo.demo_03 ( a  int
                         , b  int
                         );
go

insert into dbo.demo_03
values( 0, 0 )
    , ( 1, 1 );
go

select left( c.name, 5 ) as column_name
     , pc.leaf_offset
     , pc.is_dropped
     , pc.is_nullable
  from sys.system_internals_partition_columns pc
    join sys.partitions p
      on p.partition_id = pc.partition_id
    left join sys.columns c
      on column_id = partition_column_id 
     and c.object_id = p.object_id
  where p.object_id in ( object_id('dbo.demo_03') );
go

/*
column_name leaf_offset is_dropped is_nullable
----------- ----------- ---------- -----------
a           4           0          1
b           8           0          1
*/

select * from dbo.demo_03
  cross apply fn_PhysLocCracker ( %%physloc%% );
go

dbcc traceon(3604);
go
dbcc page([Pages_and_Extents_Architecture], 1, 228, 3) with tableresults; 
go

alter table dbo.demo_03
alter column a int not null;
go

select left( c.name, 5 ) as column_name
     , pc.leaf_offset
     , pc.is_dropped
     , pc.is_nullable
  from sys.system_internals_partition_columns pc
    join sys.partitions p
      on p.partition_id = pc.partition_id
    left join sys.columns c
      on column_id = partition_column_id 
     and c.object_id = p.object_id
  where p.object_id in ( object_id('dbo.demo_03') );
go

dbcc page([Pages_and_Extents_Architecture], 1, 228, 3) with tableresults;
go


