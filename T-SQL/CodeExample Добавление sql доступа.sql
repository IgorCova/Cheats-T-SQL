
-- быстрое добавление sql доступа
exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Card'  -- имя action (системное название, английский)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_ReadInstance' -- название процедуры(обычно название обёртки)
go

exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Card'  -- имя action (системное название, английский)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_Create' -- название процедуры(обычно название обёртки) 
go

exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Card'  -- имя action (системное название, английский)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_Write' -- название процедуры(обычно название обёртки)
go

-- быстрое добавление sql доступа
exec [ui].[UserActionSqlObject.CreateLite]
 	 @UserActionName = 'CrmNewWantCloseReason.Dict'  -- имя action (системное название, английский)
  ,@SqlObjectName  = 'dbo.dbo_CrmNewWantCloseReason_ReadDict' -- название процедуры(обычно название обёртки)
go