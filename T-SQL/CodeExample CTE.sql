
-- CTE commom table extensions
;with CTE as (
  select 
       1 as [Row]
  union all 
  select 
       [Row] + 1 
    from CTE as c
    where c.[Row] < 10
  )

select * 
  from CTE as c