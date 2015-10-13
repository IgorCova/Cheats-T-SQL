

exec dbo.dbo_AUSModule_ReadDict
go
-- Заменить(Ctrl + H) #Сущность 

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.Card'   
  ,@Caption = 'Карточка #Сущность'   
  ,@ModuleName = 'mjs_insurance.dll'
go

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.CardWrite'   
  ,@Caption = 'Карточка #Сущность (изменение)'   
  ,@ModuleName = 'mjs_crm.dll'
go

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.New'   
  ,@Caption = 'Создание #Сущность'   
  ,@ModuleName = 'mjs_crm.dll'
go

exec [ui].[UserAction.CreateLite]
   @Name = 'INSPolicySaleClaim.Dict'   
  ,@Caption = 'Справочник #Сущность'   
  ,@ModuleName = 'mjs_crm.dll'
go



