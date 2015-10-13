declare @t3 xml

set @t3 = N'<Root>
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrBusiness]" Index="[HrBusiness.pk]" Alias="[hb]" IndexKind="Clustered" />
<Object Database="[AutoSalesSS]" Schema="[dbo]" Table="[SSUBillCategory]" Index="[SSUBillCategory.ixCode]" IndexKind="NonClustered" />
<Object Database="[AutoSalesSS]" Schema="[dbo]" Table="[SSUBillCategory]" Index="[SSUBillCategory.ixCode]" IndexKind="NonClustered" />
<Object Database="[AutoSalesSBD]" Schema="[dbo]" Table="[RSMPhoneType]" Index="[RSMPhoneType.ixCode]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrPosition]" Index="[HrPosition.ixName]" Alias="[t]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Depart]" Index="[Depart.pk]" Alias="[d]" TableReferenceId="1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Depart]" Index="[Depart.ixTerOrder]" Alias="[ter]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrStaff]" Index="[HrStaff.ixDepart]" Alias="[h]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrEmployeeWork]" Index="[HrEmployeeWork.ixStaff]" Alias="[w]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Person]" Index="[Person.pk]" Alias="[s]" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Car]" Index="[Car.ixSalesman]" Alias="[c]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Car]" Index="[Car.pk]" Alias="[c]" TableReferenceId="-1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[DocCarOrder]" Index="[DocCarOrder.ixCar]" Alias="[o]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CarVinItem]" Index="[CarVinItem.ixDate]" Alias="[i]" IndexKind="Clustered" />
<Object Database="[AutoSalesSBD]" Schema="[dbo]" Table="[RSMPhone]" Index="[RSMPhone.ixEmplyeePhoneType]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Doc]" Index="[Doc.pk]" Alias="[od]" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[DocCarOrderClose]" Index="[DocCarOrderClose.ixOrder]" Alias="[oc]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[DocCarOrderClose]" Index="[DocCarOrderClose.pk]" Alias="[oc]" TableReferenceId="-1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CarModel]" Index="[CarModel.pk]" Alias="[cm]" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Person]" Index="[Person.pk]" Alias="[cx]" IndexKind="Clustered" />
<Object Database="[AutoSalesCRM]" Schema="[dbo]" Table="[CrmClientContact]" Index="[CrmClientContact.ixMain]" TableReferenceId="1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Depart]" Index="[Depart.ixHrBusiness]" Alias="[d]" TableReferenceId="2" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[ClientRepresent]" Index="[ClientRepresent.pk]" Alias="[cr]" TableReferenceId="1" IndexKind="Clustered" />
<Object Database="[AutoSalesCRM]" Schema="[dbo]" Table="[CrmClientContact]" Index="[CrmClientContact.ixMain]" TableReferenceId="2" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Depart]" Index="[Depart.ixHrBusiness]" Alias="[d]" TableReferenceId="3" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[INSCar]" Index="[INSCar.ixVIN]" Alias="[ic]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[INSPolicy]" Index="[INSPolicy.ixINSCar]" Alias="[ii]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[INSPolicy]" Index="[INSPolicy.pk]" Alias="[ii]" TableReferenceId="-1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[INSPolicyType]" Index="[INSPolicyType.pk]" Alias="[pt]" IndexKind="Clustered" />
<Object Database="[AutoSalesCRM]" Schema="[dbo]" Table="[CrmClientContact]" Index="[CrmClientContact.ixClientDealerSalesman]" TableReferenceId="3" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrEmployeeWork]" Index="[HrEmployeeWork.ixMain]" Alias="[cw]" TableReferenceId="1" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrStaff]" Index="[HrStaff.pk]" Alias="[ch]" TableReferenceId="1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[ClientRepresent]" Index="[ClientRepresent.pk]" Alias="[cr]" TableReferenceId="2" IndexKind="Clustered" />
<Object Database="[AutoSalesCRM]" Schema="[dbo]" Table="[CrmClientContact]" Index="[CrmClientContact.ixClientDealerSalesman]" TableReferenceId="4" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrEmployeeWork]" Index="[HrEmployeeWork.ixMain]" Alias="[cw]" TableReferenceId="2" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[HrStaff]" Index="[HrStaff.pk]" Alias="[ch]" TableReferenceId="2" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CVLValuation]" Index="[CVLValuation.ixSaleOrder]" Alias="[v]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CVLBuyType]" Index="[CVLBuyType.pk]" Alias="[bt]" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CarAddOnService]" Index="[CarAddOnService.ixUnique]" Alias="[t]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CarAddOnContact]" Index="[CarAddOnContact.pk]" Alias="[caoc]" IndexKind="Clustered" />
<Object Database="[AutoSalesSBD]" Schema="[dbo]" Table="[SIOCarLnkCar]" Index="[SIOCarLnkCar.ixCar]" IndexKind="NonClustered" />
<Object Database="[AutoSalesSS]" Schema="[dbo]" Table="[SSUCalc]" Index="[SSUCalc.ixCar]" IndexKind="NonClustered" />
<Object Database="[AutoSalesSS]" Schema="[dbo]" Table="[SSUCalc]" Index="[SSUCalc.pk]" TableReferenceId="-1" IndexKind="Clustered" />
<Object Database="[AutoSalesSS]" Schema="[dbo]" Table="[SSUBill]" Index="[SSUBill.ixCalc]" IndexKind="NonClustered" />
<Object Database="[AutoSalesSS]" Schema="[dbo]" Table="[SSUBill]" Index="[SSUBill.pk]" TableReferenceId="-1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[Doc]" Index="[Doc.pk]" Alias="[cd]" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[DocType]" Index="[DocType.pk]" Alias="[dt]" IndexKind="Clustered" />
<Object Database="[AutoSalesSBD]" Schema="[dbo]" Table="[SIOCarLnkCar]" Index="[SIOCarLnkCar.ixCar]" IndexKind="NonClustered" />
<Object Database="[AutoSalesSBD]" Schema="[dbo]" Table="[SIOWarranty]" Index="[SIOWarranty.ixCar]" IndexKind="NonClustered" />
<Object Database="[AutoSalesSBD]" Schema="[dbo]" Table="[SIOWarranty]" Index="[SIOWarranty.pk]" TableReferenceId="-1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[ui]" Table="[UserActionSqlObject]" Index="[UserActionSqlObject.ixSqlObject]" Alias="[s]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[ui]" Table="[UserActionSqlObject]" Index="[UserActionSqlObject.pk]" Alias="[s]" TableReferenceId="-1" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[ui]" Table="[UserAction]" Index="[UserAction.pk]" Alias="[a]" IndexKind="Clustered" />
<Object Database="[AutoSales]" Schema="[ui]" Table="[MenuItem]" Index="[MenuItem.ixAction]" Alias="[m]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CarModification]" Index="[CarModification.pk]" Alias="[m]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CarWarranty]" Index="[CarWarranty.pk]" Alias="[m]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[CarStateHistory]" Index="[CarStateHistory.ixDate]" Alias="[m]" IndexKind="NonClustered" />
<Object Database="[AutoSales]" Schema="[dbo]" Table="[DocCarOrder]" Index="[DocCarOrder.pk]" Alias="[m]" IndexKind="NonClustered" />
</Root>'

declare @command nvarchar(4000);
declare @tblIndexes table (
          DatabaseName nvarchar(20)     not null
         ,SchemaName nvarchar(130)      not null
         ,TableName nvarchar(130)       not null
         ,IndexName nvarchar(130)       not null
        )
       
insert into @tblIndexes  (
          DatabaseName
         ,SchemaName
         ,TableName
         ,IndexName
        )  
select distinct
        h.OID.value ('@Database','nvarchar(40)')                as DatabaseName
       ,h.OID.value ('@Schema','nvarchar(130)')                 as SchemaName
       ,h.OID.value ('@Table','nvarchar(130)')                  as TableName
       ,h.OID.value ('@Index','nvarchar(130)')                  as IndexName
      from @t3.nodes('/Root/Object') as  h(OID)

select 'alter index ' + t.IndexName
        + ' on ' + t.DatabaseName + '.'+ t.SchemaName + '.' + t.TableName
        + ' REBUILD'
        --+ iif(pc.partitioncount > 1, ' PARTITION=' + CAST(s.partition_number AS nvarchar(10),'')
       ,aa.avg_fragmentation_in_percent     
  from @tblIndexes as t
  inner join sys.objects as o on QUOTENAME(o.name) = t.TableName 
  inner join sys.schemas as s on s.schema_id = o.schema_id
                             and QUOTENAME(s.name) = t.SchemaName
  inner join sys.indexes as i on QUOTENAME(i.name) = t.IndexName
  --outer apply (
  --      select count (*)   as partitioncount
  --       from sys.partitions p 
  --       where p.object_id = o.object_id 
  --         and p.index_id = i.index_id
   
  -- ) as pc
  outer apply (select 
				   a.avg_fragmentation_in_percent
				 from sys.dm_db_index_physical_stats ( db_id(N'AutoSales'),object_id(N''+t.SchemaName+'.'+t.TableName+''),null,null,null) as a
				 where a.object_id = i.object_id
                    and a.index_id = i.index_id
  ) aa




  --select
  --   i.index_id
  --  ,i.name
  --  ,aa.avg_fragmentation_in_percent
  --from @tblIndexes as t
  --inner join sys.indexes as i on QUOTENAME(i.name) = t.IndexName
  --outer apply (select 
		--		   a.avg_fragmentation_in_percent
		--		 from sys.dm_db_index_physical_stats ( db_id(N'AutoSales'),object_id(N''+t.SchemaName+'.'+t.TableName+''),null,null,null) as a
		--		 where a.object_id = i.object_id
  --                  and a.index_id = i.index_id
  --) aa

