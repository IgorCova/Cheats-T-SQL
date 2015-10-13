exec dbo.dbo_HrInstruction_ReadDict NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL

declare 
   @OID        oid
  ,@OIDSEt     varchar(max) = 
    '283416301931523
    283416301934079
    283416301937767
    283416301937799
    283416301938092
    283416301930587'

declare cursorDel cursor for
  select t.i
    from master.dbo.tf_StrOfBigInt_to_Table(@OIDSEt) as t

open cursorDel
fetch next from cursorDel into
  @OID               

while @@fetch_status = 0
begin
  exec dbo.dbo_HrInstructionView_Save 
        @OID
      ,0
      ,'ок'
      ,null
      ,null
      ,null
      ,null
      ,null
      
  fetch next from cursorDel into
    @OID
end
close cursorDel
deallocate cursorDel
go 
     
declare @p6 varchar(8000)
set @p6=NULL
exec dbo.dbo_UserMessage_SetReadAll NULL,NULL,NULL,NULL,NULL,@p6 output
select @p6

