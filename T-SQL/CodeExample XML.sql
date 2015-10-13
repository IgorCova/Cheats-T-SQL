Пример:
--- Получение всех телефонов клиента одной строкой
declare
   @PersonOID oid = 281646775402499
declare
   @PersonTypeID     typeid     = dbo.[oid.TypeID](@PersonOID)
  ,@PersonInstanceID instanceid = dbo.[oid.InstanceID](@PersonOID)
-- старый способ
select replace(
               rtrim(
                      (select pp.Phone + '     ' as 'data()'
                         from dbo.PersonPhone as pp
                         where pp.[PersonOID.TypeID]     = @PersonTypeID
                          and pp.[PersonOID.InstanceID] = @PersonInstanceID
                         for xml path(''))
                    )
              ,'      '
              ,','
             ) as [Phones]
-- новый способ
select stuff(
             (select ',' + pp.Phone
                from dbo.PersonPhone as pp
                where pp.[PersonOID.TypeID]     = @PersonTypeID
                  and pp.[PersonOID.InstanceID] = @PersonInstanceID
                for xml path(''), type).value('.', 'varchar(max)')
            ,1 ,1 ,''
           ) as [Phones]
