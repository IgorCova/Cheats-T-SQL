
  declare 
     @DateTo datetime = '20140215'
    ,@DateFrom datetime = '20140115'

  declare @Dates table (DateFrom datetime not null
                   ,primary key (DateFrom))

  insert into @Dates( DateFrom)
  select dateadd(day, l.i - 1, @DateFrom)
    from master.dbo.fn_int_gen_list(datediff (day, @DateFrom , @DateTo) ) as l

  select * 
    from @Dates
