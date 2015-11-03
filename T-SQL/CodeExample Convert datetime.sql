declare @i int = 100
while (@i <= 114)
begin
    select convert(varchar ,getdate() ,@i),'select convert(varchar, getdate(), ' + cast(@i as varchar) + ')'  
    set @i += 1
end
