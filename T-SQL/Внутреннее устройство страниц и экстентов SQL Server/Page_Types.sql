/*
1: Data page 
2: Index page
3: Text Mixed Page
4: Text Page
7: Sort Page
8: GAM Page
9: SGAM Page
10: IAM Page
11: PFS Page
13: Boot Page
14: Server Configuration Page 
15: File Header Page
16: Differential Changed map
17: Bulk Change Map
18,19,20: служебные страницы
*/
use [Pages_and_Extents_Architecture];
go
--Page Types DEMO
if object_id ( N'dbo.table_demo', N'U' ) is not null
drop table dbo.table_demo;
go
create table dbo.table_demo ( id int identity primary key
                            , val_uni uniqueidentifier default newid() unique 
                            , dt datetime default getdate() 
                            , blob nvarchar(max) default replicate ( cast( 'A' as varchar(max) ), 40201 )
                            );
go
insert into dbo.table_demo
default values;
go

dbcc traceon(3604);
go
dbcc ind ( [Pages_and_Extents_Architecture], 'dbo.table_demo', -1 );
go

--1: Data page
dbcc page( [Pages_and_Extents_Architecture], 1, 109, 3 ) with tableresults;
go
--2: Index page
dbcc page( [Pages_and_Extents_Architecture], 1, 114, 5 ) with tableresults;
go
--3: Text Mixed Page
dbcc page( [Pages_and_Extents_Architecture], 1, 80, 3 );
go
--4: Text Page
dbcc page( [Pages_and_Extents_Architecture], 1, 90, 3 );
go
--10: IAM Page (Index Allocation Map) Ц карта распределени€ индекса
dbcc page( [Pages_and_Extents_Architecture], 1, 89, 3 ) with tableresults;
go

--8: GAM Page (Global Allocation Map) - глобальна€ карта распределени€
dbcc page( [Pages_and_Extents_Architecture], 1, 2, 3 ) with tableresults;
go
--9: SGAM Page (Shared Global Allocation Map) Ц обща€ глобальна€ карта распределени€
dbcc page( [Pages_and_Extents_Architecture], 1, 3, 3 ) with tableresults;
go
/*
-----------------------------------------------------------------
GAM |SGAM | “екущее использование экстента
-----------------------------------------------------------------
 1  |  0  | —вободно, в текущий момент не используетс€
 0  |  0  | ќднородный экстент или заполненный смешанный экстент
 0  |  1  | —мешанный экстент со свободными страницами
-----------------------------------------------------------------
*/

--11: PFS Page (Page Free Space) Ц распределение страниц и степень их заполнени€
dbcc page( [Pages_and_Extents_Architecture], 1, 1, 3 ) with tableresults;


--16: Differential Changed map - —хема разностных изменений
dbcc page( [Pages_and_Extents_Architecture], 1, 6, 3 ) with tableresults;
--17: Bulk Change Map - —хема массовых изменений
dbcc page( [Pages_and_Extents_Architecture], 1, 7, 3 ) with tableresults;


--13: Boot Page
dbcc page( [Pages_and_Extents_Architecture], 1, 9, 3 ) with tableresults;
dbcc dbinfo with tableresults;

--14: Server Configuration Page 
dbcc page( [master], 1, 10, 3 ) with tableresults;
exec sp_configure;

--15: File Header Page
dbcc page( [Pages_and_Extents_Architecture], 1, 0, 3 ) with tableresults;
dbcc fileheader (0,1);
