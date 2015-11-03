select distinct 
     so.xtype
    ,so.name
  from syscomments sc
  join sysobjects so on sc.id = so.id
  where sc.text like '%Payment.Pay%'       
  order by
     so.xtype
    ,so.name    
