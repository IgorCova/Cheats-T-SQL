use [Pages_and_Extents_Architecture];
go
--Pages DEMO
if object_id ( N'dbo.page_demo', N'U' ) is not null
drop table dbo.page_demo;
go
create table dbo.page_demo ( id int primary key --4  байта
                           , a  char(10)        --10 байт
                           , b  varchar(50)
                           , c  bigint          --8 байт
                           , d  datetime        --8 байт
                           , e  varbinary(8)
                           );
go
insert into dbo.page_demo
select 1, 'aaa01', 'page_demo', 1111, '20150319', 0x123; 
go
insert into dbo.page_demo
select 2, null, 'sql server', 22222, '20150319 18:00', null;
go 
insert into dbo.page_demo
select 3, 'c3', 'Alexey', 3, '20150319 20:33', 0x99999;
go

select * from dbo.page_demo
  cross apply fn_PhysLocCracker(%%physloc%%);
go

update dbo.page_demo
set c = c + 1
where id = 1;
checkpoint;
----------------------------------------------
-- Header
----------------------------------------------
dbcc traceon(3604);
go
dbcc page([Pages_and_Extents_Architecture], 1, 78, 0) with tableresults;
go

/*
m_pageId = (1:78)                    m_headerVersion = 1                  m_type = 1
m_typeFlagBits = 0x4                 m_level = 0                          m_flagBits = 0x8000
m_objId (AllocUnitId.idObj) = 29     m_indexId (AllocUnitId.idInd) = 256  
Metadata: AllocUnitId = 72057594039828480                                 
Metadata: PartitionId = 72057594038779904                                 Metadata: IndexId = 1
Metadata: ObjectId = 2105058535      m_prevPage = (0:0)                   m_nextPage = (0:0)
pminlen = 34                         m_slotCnt = 3                        m_freeCnt = 7933
m_freeData = 253                     m_reservedCnt = 0                    m_lsn = (21:128:2)
m_xactReserved = 0                   m_xdesId = (0:0)                     m_ghostRecCnt = 0
m_tornBits = 0    
*/


--идентификатор страницы                
--m_pageId = (1:78)

--версия заголовка страницы, для SQL Server 7.0 и выше всегда 1                             
--m_headerVersion = 1

--тип страницы                   
--m_type = 1 (Data page)

--Для страниц данных и индексов всегда 4. Для остальных страниц 0, кроме PFS (для них может быть значение 1, 
--указывающее на ghost-записи).
--m_typeFlagBits = 0x4 

--уровень страницы в B-дереве (0 – листовой уровень) , для всех страницы, кроме индексных значение всегда 0.                                  
--m_level = 0 

--– флаг с описанием страниц, например наличие контрольной суммы (0х200) или torn-page (0х100),  
--  а так же может указывать «грязная» или «чистая» страница                         
--m_flagBits = 0x8000
select cast(  0x8000 as int ) & cast(  0x100 as int )
     , cast(  0x8000 as int ) & cast(  0x200 as int );
select page_verify_option_desc from sys.databases 
where database_id = db_id ();


--параметры для определения Allocation Unit ID. Формула следующая: (m_indexId << 48) | (m_objId << 16)
--m_objId (AllocUnitId.idObj) = 29     
--m_indexId (AllocUnitId.idInd) = 256 
select 256 * convert( bigint, power( 2., 48 ) ) | 29 * convert( bigint, power( 2., 16 ) );

select a.container_id as PartitionId
     , p.index_id as IndexId
     , p.object_id as ObjectId
  from sys.system_internals_allocation_units a
    inner join sys.partitions p
      on a.container_id = p.partition_id
  where a.allocation_unit_id = 72057594039828480;
/* 
Metadata: AllocUnitId = 72057594039828480                                 
Metadata: PartitionId = 72057594038779904                                 
Metadata: IndexId = 1
Metadata: ObjectId = 2105058535 
*/


--указатель на предыдущую/следующую страницу В-дерева     
--m_prevPage = (0:0)                   
--m_nextPage = (0:0)

--указатель на NULL bitmap ( 4 байта заголовок записи + общая длинна всех колонок фиксированной длинны )
--pminlen = 34

--количество записей на странице                        
--m_slotCnt = 3

--количество свободного пространства на странице в байтах                        
--m_freeCnt = 7933
select 8060 - ( 54 + 51 + 52 ) + ( 36 - 2 * 3 ) 

--смещение от начала страницы до первого свободного байта             
--m_freeData = 253 
select 96 + ( 54 + 51 + 52 ) 

--количество свободного пространства в байтах, зарезервированное под транзакции (для корректного отката транзакции)                                     
--m_reservedCnt = 0

--LSN(Log Sequence Number) записи в журнале транзакций, которая изменила страницу                    
--m_lsn = (19:368:21)

--последнее значение, которое было добавлено в поле m_reservedCnt                  
--m_xactReserved = 0  

--внутренний идентификатор последней транзакции, которая изменила поле m_reservedCnt                                     
--m_xdesId = (0:0) 

--количество ghost-записей на странице                    
--m_ghostRecCnt = 0

--либо контрольная сумма, либо по 2 последних бита из секторов 1-15 (заголовок расположен в 0-ом секторе) 
--+  2 бита контроля обрыва страницы (актуально для torn-page)
--m_tornBits = -47058617               

----------------------------------------------------------------------------------------------



----------------------------------------------
-- Records
----------------------------------------------

dbcc page([Pages_and_Extents_Architecture], 1, 78, 1) with tableresults;
go
--Slot 0
/*
0000000000000000:   30002200 01000000 61616130 31202020 †0.".....aaa01    
0000000000000010:   20205804 00000000 00000000 000060a4 †  ............`¤ 
0000000000000020:   00000600 00020034 00360070 6167655f †.......4.6.page_ 
0000000000000030:   64656d6f 0123††††††††††††††††††††††††demo.# 
*/ 

--Заголовок записи ( 4 байта )
--30 00 - Структура записи, метаданные (TagA + TagB)
--00110000(TagA) 00000000(TagB) 

--TagA (Байт 0)
--начинается с Бит 1
--Бит 1 - 3 - тип:
/*
            0 = primary record. A data record in a heap that hasn't been forwarded or a data record at the leaf level of a clustered index. 
            1 = forwarded record 
            2 = forwarding record 
            3 = index record 
            4 = blob fragment 
            5 = ghost index record 
            6 = ghost data record 
            7 = ghost version record
*/
--Бит 4 (0?10) - запись имеет NULL bitmap (битовая маска)
--Бит 5 (0?20) - запись имеет столбцы переменной длинны  
--Бит 6 (0х40) - наличие versioning tag (актуально для версионника)
--Бит 7 (0х80) - указывает, что Байт №1 (TagB) содержит значения

--TagB (Байт 1)
--Либо 0х00 либо 0х01 - указатель на ghost forwarded record (фантомная перемещенная запись)

--22 00 - указатель на NULL bitmap ( 4 байта заголовок + общая длинна всех колонок фиксированной длинны )
select cast( 0x22 as int ); 
select name, type_name( user_type_id ) t, max_length
  from sys.columns
  where object_id = object_id ( N'dbo.page_demo', N'U' )
    and type_name( user_type_id ) in ( 'int', 'char', 'bigint', 'datetime' );

select sum( max_length ) l
  from sys.columns
  where object_id = object_id ( N'dbo.page_demo', N'U' )
    and type_name( user_type_id ) in ( 'int', 'char', 'bigint', 'datetime' );

--int - 4 байта
--01 00 00 00
--char(10) - 10 байт
--61 61 61 30 31 20 20 20 20 20
select cast ( 0x61616130312020202020 as varchar(50) );
select cast( 0x20 as int ), ascii( ' ' ); 
--bigint - 8 байт
--58 04 00 00 00 00 00 00
select cast( 0x0458 as int )
--datetime - 8 байт 
/*
Значения типа datetime хранятся внутри компонента SQL Server в виде 4-байтовых целых чисел. 
Первые четыре байта содержат количество дней до или после даты отсчета: 1 января 1900 года. 
Вторые четыре байта содержат текущее значение времени, представленного в виде трехсотых долей секунды, прошедших после полуночи.
*/
--00 00 00 00 60 a4 00 00
select cast( 0x0000a460 as int )
	   , dateadd( d, 42080, '19000101' );

--NULL bitmap
--06 00 - кол-во столбцов 
--00 --> 000000


--02 00 - кол-во столбцов переменной длинны

--указатель на стобцы переменной длинны
--34 00
select cast( 0x0034 as int ); --52
select 4 + 30 + 2 + 1 + 2 + 4 + 9;
select datalength(b), datalength(e), * from dbo.page_demo;
--36 00 
select cast( 0x0036 as int ); --54
select 4 + 30 + 2 + 1 + 2 + 4 + 9 + 2;

--Столбцы переменной длинны
--70 61 67 65 5f 64 65 6d 6f - 9 байт
select cast( 0x706167655f64656d6f as varchar(50) );
--01 23 - 2 байта


--Slot 1
/*
0000000000000000:   30002200 02000000 05002f84 00000000 †0.".......??.... 
0000000000000010:   0000ce56 00000000 000080a1 280160a4 †..?V......??(.`¤ 
0000000000000020:   00000600 22010033 0073716c 20736572 †...."..3.sql ser 
0000000000000030:   766572†††††††††††††††††††††††††††††††ver  
*/

--30002200 02000000 61616130 31202020 2020ce56 00000000 000080a1 280160a4 00000600 22010033 0073716c 20736572 766572

--Заголовок записи ( 4 байта )
--30 00 - Тип  
--22 00 - указатель на NULL bitmap ( 4 байта заголовок + общая длинна всех колонок фиксированной длинны )

--int - 4 байта
--02 00 00 00
--char(10) - 10 байт
--05 00 2f 84 00 00 00 00 00 00
select cast ( 0x05002f84000000000000 as varchar(50) );
--bigint - 8 байт
--ce 56 00 00 00 00 00 00
select cast ( 0x56ce as int );
--datetime - 8 байт
--80 a1 28 01 60 a4 00 00 
select cast( 0x0000a460 as int )
	  , dateadd( d, 42080, '19000101' );
select cast( 0x0128a180 as int )
	  , dateadd( ms, 19440000*3.33333333333, '19000101' );

--NULL bitmap
--06 00 - кол-во столбцов 
--22 --> 100010

--01 00 - кол-во столбцов переменной длинны
--указатель на стобцы переменной длинны
select datalength(b), datalength(e), * from dbo.page_demo;
--00 33 
select cast( 0x33 as int );
select 4 + 30 + 2 + 1 + 2 + 2 + 10;

--0073716c 20736572 766572
select cast ( 0x73716c20736572766572 as varchar(50) );

--Slot 2
/*
0000000000000000:   30002200 03000000 63332020 20202020 †0.".....c3      
0000000000000010:   20200300 00000000 000050a7 520160a4 †  ........P§R.`¤
0000000000000020:   00000600 00020031 00340041 6c657865 †.......1.4.Alexe
0000000000000030:   79099999 ††††††††††††††††††††††††††††y	..
*/  

--Заголовок записи ( 4 байта )
--30 00 - Тип  
--22 00 - указатель на NULL bitmap ( 4 байта заголовок + общая длинна всех колонок фиксированной длинны )

--int - 4 байта
--03 00 00 00
--char(10) - 10 байт
--63 33 20 20 20 20 20 20 20 20
select cast ( 0x63332020202020202020 as varchar(50) );
--bigint - 8 байт
--03 00 00 00 00 00 00 00
select cast ( 0x56ce as int );
--datetime - 8 байт
--50 a7 52 01 60 a4 00 00
select cast( 0x0000a460 as int )
	   , dateadd( d, 42080, '19000101' );
select cast( 0x0152a750 as int )
	   , dateadd( ms, 22194000**3.33333333333, '19000101' );

--NULL bitmap
--06 00 - кол-во столбцов 
--10 --> 010000

--02 00 - кол-во столбцов переменной длинны
--указатель на стобцы переменной длинны
select datalength(b), datalength(e), * from dbo.page_demo;
--0031
select cast( 0x0031 as int );
select 4 + 30 + 2 + 1 + 2 + 4 + 6;
--0034
select cast( 0x0034 as int );
select 4 + 30 + 2 + 1 + 2 + 4 + 6 + 3;


--41 6c 65 78 65 79
select cast ( 0x416c65786579 as varchar(50) );
--09 99 99


----------------------------------------------------------------------------------------------


----------------------------------------------
-- Row Offset 
----------------------------------------------

dbcc page([Pages_and_Extents_Architecture], 1, 78, 1) with tableresults;
go
/*
2 (0x2) - 201 (0xc9) 
1 (0x1) - 150 (0x96) 
0 (0x0) - 96 (0x60) 
*/
delete from dbo.page_demo
where id = 2;

select * from dbo.page_demo;

insert into dbo.page_demo
select 4, 'c4', 'Alexey', 4, null, 0x99999;
go

dbcc page([Pages_and_Extents_Architecture], 1, 78, 0) with tableresults;
go

alter table dbo.page_demo rebuild;

select * from dbo.page_demo
  cross apply fn_PhysLocCracker(%%physloc%%);
go