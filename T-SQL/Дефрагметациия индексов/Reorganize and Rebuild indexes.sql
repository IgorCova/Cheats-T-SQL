-- Ensure a USE <databasename> statement has been executed first.
set nocount on;

------------------------------
begin Tran_Reindex
------------------------------
  declare
     @objectid int
    ,@indexid  int
    ,@partitioncount bigint
    ,@schemaname     nvarchar(130)
    ,@objectname     nvarchar(130)
    ,@indexname      nvarchar(130) 
    ,@partitionnum   bigint
    ,@frag           float
    ,@command        nvarchar(4000) 

  declare @IndexTbl table (
       objectid         int 
      ,index_id         int 
      ,partition_number int 
      ,frag             float)

  insert into @IndexTbl ( 
     objectid
    ,index_id
    ,partition_number
    ,frag)
  select
       object_id                     as objectid
      ,index_id                      as indexid
      ,partition_number              as partitionnum
      ,avg_fragmentation_in_percent  as frag
    from sys.dm_db_index_physical_stats (db_id() ,null ,null ,null ,'LIMITED')
    where avg_fragmentation_in_percent > 5.0
      and index_id > 0

  declare Cur_Partitions cursor local fast_forward for 
    select
         t.objectid
        ,t.index_id
        ,t.partition_number
        ,t.frag
      from @IndexTbl as t

  open Cur_Partitions
  fetch next from Cur_Partitions into 
         @objectid
        ,@indexid
        ,@partitionnum
        ,@frag

  while @@fetch_status = 0
  begin
    select
         @objectname = quotename(o.name)
        ,@schemaname = quotename(s.name)
      from sys.objects  as o
      join sys.schemas  as s on s.schema_id = o.schema_id
      where o.object_id = @objectid

    select
          @indexname = quotename(name)
      from sys.indexes
      where object_id = @objectid
        and index_id = @indexid

    select
          @partitioncount = count(*)
      from sys.partitions
      where object_id = @objectid
        and index_id = @indexid

      -- 30 is an arbitrary decision point at which to switch between reorganizing and rebuilding.
    if @frag < 30.0
      set @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname 
                   + N'.' + @objectname + N' REORGANIZE'
    if @frag >= 30.0
      set @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname 
                   + N'.' + @objectname + N' REBUILD'
    if @partitioncount > 1
      set @command = @command + N' PARTITION=' + cast(@partitionnum as nvarchar(10))

    exec (@command)
    print 'Executed: ' + @command

    fetch next from Cur_Partitions into 
         @objectid
        ,@indexid
        ,@partitionnum
        ,@frag
  end
  close Cur_Partitions
  deallocate Cur_Partitions
------------------------------
rollback tran Tran_Reindex
print 'rollback tran Tran_Reindex'
  --commit Tran_Reindex
------------------------------
go
