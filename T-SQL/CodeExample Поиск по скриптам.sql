select distinct 
     so.xtype
    ,so.name
  from syscomments sc
  join sysobjects so on sc.id = so.id
  where sc.text like '%primary key nonclustered%'       
  order by
     so.xtype
    ,so.name    
    'CHService.CalcTime'