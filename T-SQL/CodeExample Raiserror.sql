  if 1 <> 0    
    set @ErrMsg = 'Проблема с настройкой сегмента ReCar!'      

  if @ErrMsg is not null
  begin      
    set @ret = -1
    if @@trancount > 0 rollback
    --/*[+debug]
    select @Log_RCount = @cnt, @Log_Comment = '/ERROR/' + @ErrMsg
    exec dbo.[LogData.Save] @Log_SessionID, @log_sesid, @@procid, @Log_RCount, @Log_Comment, @debug_info, @debug_shift out, @Log_dtBgn out, @Log_dtSubaction out, @Log_@dtAction out, 1, 1, @ret
    --[-debug]*/
    raiserror (@ErrMsg, 13, 1)
    return (@ret)  
  end