set nocount on
set quoted_identifier, ansi_nulls, ansi_warnings, arithabort, concat_null_yields_null, ansi_padding on
set numeric_roundabort off
set transaction isolation level read uncommitted
set xact_abort on
go

----------------------------------------------
-- <PROC> [dbo].[GetBlankExtendedProperty]
----------------------------------------------
exec dbo.sp_object_create '[dbo].[GetBlankExtendedProperty]', 'P'
go

/*
///<description>
///Процедура возвратит шаблон для вызова Процедуры 
 dbo.FillExtendedProperty с заполненными параметрами
///</description>
*/
alter procedure [dbo].[GetBlankExtendedProperty]
   
   @ObjSysName     sysname
   
  ,@debug_info     int          = 0
  ,@debug_shift    varchar(100) = ''
  ,@log_sesid      int          = null
as
begin
------------------------------------------------
-- v1.0: Created by Kovalenko Igor 17.02.2014
------------------------------------------------
  set nocount on
  set quoted_identifier, ansi_nulls, ansi_warnings, arithabort,
      concat_null_yields_null, ansi_padding on
  set numeric_roundabort off
  set transaction isolation level read uncommitted
  set xact_abort on
  set ansi_padding on
  ------------------------------------
  -- Debugging
  --/*[+debug]
    declare @Log_SessionID int, @Log_RCount int, @Log_Comment varchar(4000), @Log_dtBgn datetime, @Log_dtSubaction datetime, @Log_@dtAction datetime
    select @Log_RCount = null, @Log_Comment = 'Start Point.'
    exec dbo.[LogData.Save] @Log_SessionID out, @log_sesid, @@procid, @Log_RCount, @Log_Comment, @debug_info, @debug_shift out, @Log_dtBgn out, @Log_dtSubaction out, @Log_@dtAction out, 1, 0
  --[-debug]*/
  -----------------------------------------------------------------
  declare
     @res     int      -- для Return-кодов вызываемых процедур.
    ,@ret     int      -- для хранения Return-кода данной процедуры.
    ,@err     int      -- для хранения @@error-кода после вызовов процедур.
    ,@cnt     int      -- для хранения количеств обрабатываемых записей.
    ,@ErrMsg  varchar(1000) -- для формирования сообщений об ошибках  
    
    ,@El           varchar(2) = master.dbo.fn_el()
    ,@Params       varchar(max) 
    ,@Blank        varchar(max)
    
    ,@ExecuterName varchar(256)
  --------------------------------------     
  if exists( select 
                  p.name
               from sys.objects             as s
               join sys.extended_properties as p on p.major_id = s.object_id
                                                and p.minor_id = 0
                                                and p.class = 1
                                                and p.name is not null
               where s.[object_id] = object_id(@ObjSysName)
                 and p.[value] is not null)
    return
  else
  --|| Если в Extended Properties ничего не указано
  begin 
    
    select
          @ExecuterName = p.MiddleName
       from dbo.HrEmployeeInfo      as i
       left join dbo.NaturalPerson  as p on p.[OID.TypeID] = i.[OID.TypeID]
                                        and p.[OID.InstanceID] = i.[OID.InstanceID]
       where i.UserID = dbo.[User.CurrentID]()
         
    --|| Системные параметры объекта (Не обязательные для описания)
    ;with SysParams (Name) as
     (select val as Name from master.dbo.tf_StrOfStr_to_Table('@debug_info, @debug_shift, @log_sesid, @GUID, @InstanceID, @OID, @TypeID, @nocheck_trancnt, @noraiserror, @out_errmsg, @UpdateDateCheck, @UpdateDateUTCPrev')) 

    --|| Список входных параметров без описания
    select
         @Params =  (select '   ,' + c.Name + ' =  \n' + char(10) as 'data()' 
      from sys.syscolumns               as c
      left join sys.extended_properties as p on p.major_id = c.id
                                            and p.minor_id = 0
                                            and p.class = 1
                                            and p.Name = c.Name   
      where c.id = object_id(@ObjSysName)
        and c.Name not in (select Name from SysParams)   
        and isnull(p.Value, '') = ''
      for xml path(''))     
      
    select 
       @Params       = '     ' + right(@Params, len(@Params) - 4) -- Для того чтобы убрать первую запятую с пробелами 
    select @Blank = 
      '----------------------------------------------' + @El + 
      ' -- <Заполнение Extended Property объекта>'     + @El + 
      '----------------------------------------------' + @El +       
      'exec dbo.FillExtendedProperty'                  + @El 
          + '   @ObjSysName  = ''' + @ObjSysName  + ''''   + @El  
          + '  ,@Author      = ''' + isnull(@ExecuterName,'') +  ''''  + @El
          + '  ,@Description = ''Описание объекта ' + @ObjSysName + ''''                 + @El  
          + '  ,@Params = ''' + @El + isnull(left(@Params, len(@Params) - 1), '') + '''' + @El  
          + 'go'
    print @Blank
  end 
  -----------------------------------------------------------------
  -- End Point
  select @ret = 0
  /*[+debug]
    select @Log_RCount = @cnt, @Log_Comment = 'End Point. OID = ' + master.dbo.fn_dbg_BigInt(@OID) + ', TypeID = ' + master.dbo.fn_dbg_Int(@TypeID) + ', InstanceID = ' + master.dbo.fn_dbg_Int(@InstanceID) + ', GUID = ' + master.dbo.fn_dbg_Guid(@GUID) + '.'
    exec dbo.[LogData.Save] @Log_SessionID, @log_sesid, @@procid, @Log_RCount, @Log_Comment, @debug_info, @debug_shift out, @Log_dtBgn out, @Log_dtSubaction out, @Log_@dtAction out, 1, 1, @ret
  --[-debug]*/
  return (@ret)
end
go
----------------------------------------------
-- <WRAPPER>
----------------------------------------------
exec [dbo].[GdbProc.CreateWrapper] '[dbo].[GetBlankExtendedProperty]'
go
----------------------------------------------
-- <Filling Extended Property>
----------------------------------------------
exec dbo.FillExtendedProperty
   @ObjSysName = '[dbo].[GetBlankExtendedProperty]'
  ,@Author = 'Kovalenko Igor'
  ,@Description = 'Процедура возвратит шаблон для вызова Процедуры 
                   dbo.FillExtendedProperty с заполненными параметрами'
  ,@Params = ' @ObjSysName  = Имя обьекта в MS SQL Server.'             
            
go

/* ОТЛАДКА: dbo.dbo_GetBlankExtendedProperty
declare @ret int, @err int, @runtime datetime= getdate()

exec @ret = [dbo].[GetBlankExtendedProperty] 
   @ObjSysName    = 'dbo.[RequestCar.Write]'       
  --,@debug_info      = 0xFF
  
select @err = @@error
select @ret as [RETURN], @err as [ERROR], convert(varchar(20), getdate()-@runtime, 114) as [RUN_TIME]
--*/
go