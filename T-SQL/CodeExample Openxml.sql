declare @idoc int
  exec sp_xml_preparedocument @idoc output, @PersonSet
  
  insert into @Pay ( 
     PersonTypeID
    ,PersonInstanceID
    ,MerchantID
    ,Pwd 
  )
  select
       dbo.[oid.TypeID](PersonOID)
      ,dbo.[oid.InstanceID](PersonOID)
      ,MerchantID
      ,Pwd
    from openxml(@idoc, '/Root/Person/PersonOID', 8)
    with(PersonOID bigint '../PersonOID'
    	  ,MerchantID varchar(256) '../MerchantID'
        ,Pwd varchar(256) '../Pwd'
        )

  exec sp_xml_removedocument @idoc 