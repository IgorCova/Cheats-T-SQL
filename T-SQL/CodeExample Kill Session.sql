

use AutoSales
go
select
     u.Name
    ,t.session_id
    ,p.loginame
    ,t.transaction_id
    ,t.is_user_transaction
    ,t.is_local
    ,a.name
    ,convert(varchar(20) ,getdate() - a.transaction_begin_time ,8) as Duration
    ,p.hostname
    ,p.loginame
    ,p.login_time
  from sys.dm_tran_session_transactions t
  left join sys.dm_tran_active_transactions a on a.transaction_id = t.transaction_id
  left join sys.sysprocesses p on p.spid = t.session_id
  left join dbo.[User.View] u on u.[login] = p.loginame

  kill 165 --session_id
