  ---------------------------------- Вычислим IP компьютера пользователя
  declare @IP varchar(50)
  exec  master. [dbo].[sp_get_my_ip_address]
     @ip_address = @IP out     
  select @IP
