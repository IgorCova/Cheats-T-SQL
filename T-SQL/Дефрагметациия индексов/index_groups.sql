



select
     mid.database_id             as [Id Базы]
    ,db_name(mid.database_id)    as [db_name]
    ,mid.object_id               as [Id Объекта]
    ,schema_name(sch.schema_id)  as [Схема]
    ,object_name(mid.object_id)  as [Объект]
    ,migs.avg_user_impact        as [% Оптимизации]
    ,convert( decimal(28 ,1)
      ,migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans)) as 
     [Вес улучшения]
    ,'Create Index IX_Auto_' + schema_name(sch.schema_id) + '_' + object_name(mid.object_id) 
     + '_' +
     convert(varchar ,mig.index_group_handle) + '_' + convert(varchar ,mid.index_handle) 
     +
     ' ON ' + mid.statement + '( ' + isnull(mid.equality_columns ,'') +
     case 
       when mid.equality_columns is not null and mid.inequality_columns is not 
            null then ', '
       else ''
     end +
     isnull(mid.inequality_columns ,'') + ' )' +
     isnull(' INCLUDE( ' + mid.included_columns + ' )' ,'') as [Как создать]
  from sys.dm_db_missing_index_groups mig
  inner join sys.dm_db_missing_index_group_stats migs on migs.group_handle = mig.index_group_handle
  inner join sys.dm_db_missing_index_details mid on mig.index_handle = mid.index_handle
  inner join sys.objects o on o.object_id = mid.object_id
  inner join sys.schemas sch on sch.schema_id = o.schema_id
  where convert( decimal(28 ,1)
         ,migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans)) 
        > 1000
    and object_name(mid.object_id) is not null
    and db_name(mid.database_id) = 'AutoSales'
        --and migs.avg_user_impact > 70.0       
  order by
     migs.avg_total_user_cost * migs.avg_user_impact * (migs.user_seeks + migs.user_scans) 
     desc