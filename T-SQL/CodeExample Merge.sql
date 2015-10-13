
  -----------------------------------------------------------
  merge [dbo].[Address] as trg
    using (
      select
           a.AddressString     as AddressString
          ,a.RegistrationDate  as RegistrationDate
          ,a.[OID.InstanceID]  as InstanceID
        from dbo.Person     as o
        join dbo.[Address]  as a on a.[OID.TypeID] = o.[LegalAddressOID.TypeID]
                                and a.[OID.InstanceID] = o.[LegalAddressOID.InstanceID]                           
        where o.[OID.TypeID] = @OldTypeID
          and o.[OID.InstanceID] = @OldInstanceID) as src (AddressString, RegistrationDate, InstanceID)
    on (    trg.[OID.TypeID] = @TypeID
        and trg.[OID.InstanceID] = @InstanceID
        and src.InstanceID is not null)
         
    when matched then
      update set    
            trg.AddressString = isnull(nullif(fn.trim(trg.AddressString),''), src.AddressString)
          ,trg.RegistrationDate = isnull(trg.RegistrationDate, src.RegistrationDate)
             
    when not matched by target then
      insert (        
         UserID
        ,[BDDOID.TypeID]
        ,[BDDOID.InstanceID]
        ,IsEnable) 
      values (
          UserID 
        ,BDDTypeID 
        ,BDDInstanceID 
        ,IsEnable);
    
  -----------------------------------------------------------   
  -- With CTE
  -- Обертка table в CTE перед merge 
  -- поможет избежать fullScan index
  /*
  ;with CTE as (
      select  *
        from [Table] as t
        where t.[OID.TypeID] = 1
          and t.[OID.InstanceID] = 2)
    merge CTE as trg
  */ ------------------------
  ;with TargetCte as (
      select
           *
        from dbo.CrmNewWantCloseReasonToWantType as t
        where t.[WantCloseReasonOID.TypeID] = @TypeID
          and t.[WantCloseReasonOID.InstanceID] = @InstanceID)

    merge TargetCte as trg
      using (
        select
             t.TypeID
            ,t.InstanceID
            ,@TypeID
            ,@InstanceID
          from @WantTypes as t) as src(WantTypeTypeID, WantTypeInstanceID, WantCloseReasonTypeID, WantCloseReasonInstanceID)
      on (   trg.[WantTypeOID.TypeID] = src.WantTypeTypeID
         and trg.[WantTypeOID.InstanceID] = src.WantTypeInstanceID)
    when not matched by target then
      insert ( 
         [WantCloseReasonOID.TypeID]
        ,[WantCloseReasonOID.InstanceID]
        ,[WantTypeOID.TypeID]
        ,[WantTypeOID.InstanceID]
      ) values (
         src.WantCloseReasonTypeID
        ,src.WantCloseReasonInstanceID
        ,src.WantTypeTypeID 
        ,src.WantTypeInstanceID)
    when not matched by source then
      delete;
  -----------------------------------------------------------

   
   