set nocount on
set quoted_identifier, ansi_nulls, ansi_warnings, arithabort, concat_null_yields_null, ansi_padding on
set numeric_roundabort off
set transaction isolation level read uncommitted
set xact_abort on
go

----------------------------------------------
-- <VIEW> [dbo].[TableName.View]
----------------------------------------------
exec dbo.sp_object_create N'[dbo].[TableName.View]', 'V'
go

alter view [dbo].[TableName.View]
as
select
     *
  from [dbo].TableName                                    
  left join dbo.Client             as c on c.[OID.TypeID] = t.[ClientOID.TypeID]
                                       and c.[OID.InstanceID] = t.[ClientOID.InstanceID]

  left join dbo.[HrEmployee]       as h on h.[OID.TypeID] =  t.[EmployeeOID.TypeID]
                                       and h.[OID.InstanceID] = t.[EmployeeOID.InstanceID]
go

/*
select * from [dbo].[TableName.View]
--*/
go
