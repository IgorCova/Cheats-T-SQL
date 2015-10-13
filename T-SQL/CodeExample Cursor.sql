    
--ƒл€ структурированных данных, которые могут изменитьс€ во врем€ fetch курсора
--Ќужно использовать
--  declare Cur cursor Local static forward_Only read_only for

--¬ случае с выборкой  курсором из табличной переменной
--Ќужно использовать
--   declare Cur cursor local fast_forward for


    declare Cur_Name cursor local fast_forward for 
      select
           cc.OID
        from dbo.CVLValuationConfirm as cc
        where cc.[ValuationOID.TypeID] = @TypeID
          and cc.[ValuationOID.InstanceID] = @InstanceID  
          
    open Cur_Name
    fetch next from Cur_Name into
        @OID               
        
    while @@fetch_status = 0
    begin
      --[+Object.Delete]
      exec @res = [dbo].[CVLValuationConfirm.Delete]
         @OID               = @OID
        ,@debug_info        = @debug_info
        ,@debug_shift       = @debug_shift
        ,@log_sesid         = @Log_SessionID
      select @err = @@error
        
      if (@res != 0 or @err != 0) 
      begin
        select @ret = case when @res = 0 then @err else @res end
        if @@trancount > 0 rollback
        --/*[+debug]
        select @Log_RCount = null, @Log_Comment = 'return (' + master.dbo.fn_dbg_Int(@ret) + '). ERROR_ON /exec [dbo].[CVLValuationConfirm.Delete]/; ret (' + master.dbo.fn_dbg_Int(@res) + ')' + case when @err = 0 then '.' else '; error (' + master.dbo.fn_dbg_Int(@err) + ').' end
        exec dbo.[LogData.Save] @Log_SessionID, @log_sesid, @@procid, @Log_RCount, @Log_Comment, @debug_info, @debug_shift out, @Log_dtBgn out, @Log_dtSubaction out, @Log_@dtAction out, 1, 1, @ret
        --[-debug]*/
        return (@ret)
      end
      --[-Object.Delete]
      fetch next from Cur_Name into
          @OID  
    end
    close Cur_Name
    deallocate Cur_Name