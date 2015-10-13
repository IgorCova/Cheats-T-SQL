declare
   @Name           varchar(256)
  ,@Caption        varchar(256)
  ,@ActionName     varchar(128)
  ,@ParentName     varchar(256)
  ,@IconOID        oid
  ,@ParentOID      oid
  ,@IsGroup        bool
  ,@ActionOID      oid

----------------------------------------------------------------------------
-- данные для создания одного пункта меню
select
     @Caption    = 'Создание причины закрытия' -- заголовок
    ,@Name       = 'FuncMenuRoot.CRM.NewCrmClientContact.CrmNewWantCloseReason->New' -- название
    ,@ActionName = 'CrmNewWantCloseReason.Card' -- экшен
    ,@ParentName = 'FuncMenuRoot.CRM.NewCrmClientContact' -- название из карточки элемента меню, который станет родителем нашему элементу меню
    ,@IconOID    = 281483566645250 -- иконка красная книжечка
    ,@IsGroup    = 0
----------------------------------------------------------------------------
select
    @ParentOID = t.[OID]
  from ui.MenuItem as t
  where t.Name = @ParentName

select
     @ActionOID = t.[OID]
  from ui.UserAction as t
  where t.Name = @ActionName

if (@ActionOID is not null)
  and (@ParentOID is not null)
begin
  exec dbo.ui_MenuItem_Create @ParentOID = @ParentOID   
    ,@Name = @Name   
    ,@Caption = @Caption   
    ,@IconOID = @IconOID   
    ,@IsGroup = @IsGroup   
    ,@ActionOID = @ActionOID
  
  select
       'Успех'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
end
else
  select
       'Ошибка'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
go
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

declare
   @Name           varchar(256)
  ,@Caption        varchar(256)
  ,@ActionName     varchar(128)
  ,@ParentName     varchar(256)
  ,@IconOID        oid
  ,@ParentOID      oid
  ,@IsGroup        bool
  ,@ActionOID      oid
----------------------------------------------------------------------------
-- данные для создания одного пункта меню
select
     @Caption = 'Причины закрытия' -- заголовок
    ,@Name           = 'FuncMenuRoot.CRM.NewCrmClientContact.CrmNewWantCloseReason->Dict' -- название
    ,@ActionName     = 'CrmNewWantCloseReason.Dict' -- экшен
    ,@ParentName     = 'FuncMenuRoot.CRM.NewCrmClientContact' -- название из карточки элемента меню, который станет родителем нашему элементу меню
    ,@IconOID        = 281483566645250 -- иконка красная книжечка
    ,@IsGroup        = 0
----------------------------------------------------------------------------
select
     @ParentOID = t.[OID]
  from ui.MenuItem as t
  where t.Name = @ParentName

select
     @ActionOID = t.[OID]
  from ui.UserAction as t
  where t.Name = @ActionName

if (@ActionOID is not null)
  and (@ParentOID is not null)
begin
  exec dbo.ui_MenuItem_Create @ParentOID = @ParentOID   
    ,@Name = @Name   
    ,@Caption = @Caption   
    ,@IconOID = @IconOID   
    ,@IsGroup = @IsGroup   
    ,@ActionOID = @ActionOID
  
  select
       'Успех'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
end
else
  select
       'Ошибка'
      ,@Caption    as '@Caption'
      ,@ParentOID  as '@ParentOID'
      ,@ActionOID  as '@ActionOID'
----------------------------------------------------------------------------
go