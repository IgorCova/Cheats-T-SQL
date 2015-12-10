/*
В новом SQL Server 2011 (Denali) расширяются возможности команды Order By с помощью двух долгожданных дополнительных команд:
    Offset (смещение)
    Fetch First или Fetch Next (взять первые… или взять следующие…)

Offset
Использование данной команды позволяет пропустить указанное количество строк перед тем как выводить результаты запроса. Что под этим подразумевается: Допустим, у нас есть 100 записей в таблице и нужно пропустить первые 10 строк и вывести строки с 11 по 100. Теперь это легко решается следующим запросом:

Select *
From  <SomeTable>
Order by  <SomeColumn>
Offset 10 Rows

Для тех товарищей, которые практикуют .Net должен быть знаком метод расширения для коллекций Skip, который пропускает указанное количество строк. Так вот выражение Offset работает точно так же. После того как данные упорядочены каким-либо образом, можно применять выражение Offset.

Ситуации, в которых может быть использовано выражение Offset
Во всех последующих примерах на Offset будет использовать набор данных построенных в результате данного скрипта:
*/
-- объявление табличной переменной
declare @tblSample table (
   PersonName varchar(50) 
  ,Age        int 
  ,[address]  varchar(100))

-- заполнение данными
insert into @tblSample ( 
   PersonName
  ,Age
  ,[address] 
)
select
     'Person Name' + cast(t.Number as varchar) as PersonName
    ,Number                                    as Age
    ,'Address' + cast(t.Number as varchar)     as [address]
  from master..spt_values as t
  where t.[type] = 'p' 
    and t.Number between 1 and 5

--Задача 1. Пропустить первые 10 записей и показать остальные.

--Скрипт будет простой.

select
     *
  from @tblSample       
  order by
     Age
  offset 10 Row

--Или
select
     *
  from @tblSample       
  order by
     Age
  offset (10) rows

--Вывод результатов будет таким:
/*
Person Name      Age      Address
Person Name11    11       Address11
Person Name12    12       Address12
. . . . .  . . . . . . . . .
. . . . . .. . . . . . . . .
Person Name49    49       Address49
Person Name50    50       Address50
*/

--Неважно, какое слово использовать после указания количества строк: Row или Rows – они синонимы в данном случае.

--Задача 2. Передать количество строк для пропуска в виде переменной

-- Объявляем переменную в которой будет содержаться кол-во строк для пропуска
declare @RowSkip as int
-- Выставляем количество строк для пропуска
set @RowSkip = 10

-- получаем результат
select
     *
  from @tblSample       
  order by
     Age
  offset @RowSkip Row

--Задача 3. Задать количество строк для пропуска в виде выражения

-- получить строки с 14 по 50
select
     *
  from @tblSample       
  order by
     Age
  offset ( select
                max(number) / 99999999
             from master..spt_values) rows


--Выражение select MAX(number)/99999999 from master..spt_values вернет число 14.

--Задача 4. Задать количество строк для пропуска в виде пользовательской функции
select
     *
  from @tblSample       
  order by
     Age
  offset ( select dbo.fn_test()) rows

---Код для скалярной пользовательской функции

create function fn_test()
returns int
as
begin
  declare @ResultVar as int
  set @ResultVar = 10
  return @ResultVar
end
go

---Задача 5. Использование Offset с Order by внутри представлений (view), функций, подзапросах, вложенных таблицах, общих выражениях для таблиц (Common Table Expressions — CTE).

--Например, использование в обобщенных табличных выражениях.
;with Cte as
( select
        *
    from @tblSample       
    order by
        Age
    offset 10 rows)
select
    *
  from Cte

--Пример ниже показывает использование Offset и Order by внутри вложенной таблицы.

select
     *
  from ( select
              *
           from @tblSample  
           where Age > 10       
           order by
              Age
           offset 10 rows) as PersonDerivedTable

--И еще пример на работу Offset и Order с представлениями.
/*
-- Создание view
create view vwPersonRecord as
select
     *
  from @tblSample
go
*/
-- выборка данных из view
select
     *
  from vwPersonRecord  
  where Age > 10       
  order by
     Age
  offset 10 rows
/*go

drop view vwPersonRecord
go
drop function fn_test
go
*/

--- Использование Fetch First / Fetch Next

/*
Эти ключевые слова используются для уточнения количества возвращаемых строк после пропуска массива строк по выражению Offset. Представьте, что у нас есть 100 строк и нам надо пропустить первые 10 и получить следующие 5 строк. Т.е. надо получить строки с 11 по 15.

select
     *
  from <SomeTable >       
  order by
     <SomeColumn >
  offset 10 rows
  fetch next 5 rows only; -- или Fetch First 5 Rows Only
 */

select
     *
  from @tblSample       
  order by
     Age
  offset 10 Row
  fetch first 5 rows only

-- переменная для указания смещения
declare @RowSkip as int
-- переменная для указания кол-ва возвращаемых строк
declare @RowFetch as int

-- кол-во строк для пропуска
set @RowSkip = 10
-- кол-во строк для возврата
set @RowFetch = 5

-- вывод строк с 11 по 15
select
     *
  from @tblSample       
  order by
     Age
  offset @RowSkip rows
  fetch next @RowFetch rows only
 
--В целом и общем, с этими ключевыми словами можно делать все то же самое, что и с Offset. Подзапросы, представления, функции и т.д.
