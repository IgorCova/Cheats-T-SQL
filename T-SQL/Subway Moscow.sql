
/*
<description>
   Subway Moscow 06.04.2015
   Станции Месковского Метрополитена
   Данные актуальны на 06.04.2015
</description>
*/
------------------------------------------------
-- v1.0: Created by Сova Igor 06.04.2015
------------------------------------------------
declare
   @idoc        int
  ,@LineXML     xml
  ,@StationXML  xml

set @LineXML =
 '<?xml version="1.0" encoding="windows-1251"?>
  <Root>
    <row ID="1" Name="Сокольническая" ColorRGB="ED1B35" ColorName="Красная"/>
    <row ID="2" Name="Замоскворецкая" ColorRGB="44B85C" ColorName="Зелёная"/>
    <row ID="3" Name="Арбатско-Покровская" ColorRGB="0078BF" ColorName="Синяя"/>
    <row ID="4" Name="Филёвская" ColorRGB="19C1F3" ColorName="Голубая"/>
    <row ID="5" Name="Кольцевая" ColorRGB="894E35" ColorName="Коричневая"/>
    <row ID="6" Name="Калужско-Рижская" ColorRGB="F58631" ColorName="Оранжевая"/>
    <row ID="7" Name="Таганско-Краснопресненская" ColorRGB="8E479C" ColorName="Фиолетовая"/>
    <row ID="8" Name="Калининско-Солнцевская" ColorRGB="FFCB31" ColorName="Жёлтая"/>
    <row ID="9" Name="Серпуховско-Тимирязевская" ColorRGB="A1A2A3" ColorName="Серая"/>
    <row ID="10" Name="Люблинско-Дмитровская" ColorRGB="B3D445" ColorName="Салатовая"/>
    <row ID="11" Name="Каховская" ColorRGB="79CDCD" ColorName="Бирюзовая"/>
    <row ID="12" Name="Бутовская" ColorRGB="ACBFE1" ColorName="Серо-голубая"/>
  </Root>'

set @StationXML =
  '<?xml version="1.0" encoding="windows-1251"?>
  <Root>
    <row LineID="8"  Name="Авиамоторная"/>
    <row LineID="2"  Name="Автозаводская"/>
    <row LineID="6"  Name="Академическая"/>
    <row LineID="4"  Name="Александровский сад"/>
    <row LineID="6"  Name="Алексеевская"/>
    <row LineID="2"  Name="Алма-Атинская"/>
    <row LineID="9"  Name="Алтуфьево"/>
    <row LineID="9"  Name="Аннино"/>
    <row LineID="3"  Name="Арбатская"/>
    <row LineID="4"  Name="Арбатская"/>
    <row LineID="2"  Name="Аэропорт"/>
    <row LineID="6"  Name="Бабушкинская"/>
    <row LineID="4"  Name="Багратионовская"/>
    <row LineID="7"  Name="Баррикадная"/>
    <row LineID="3"  Name="Бауманская"/>
    <row LineID="7"  Name="Беговая"/>
    <row LineID="2"  Name="Белорусская"/>
    <row LineID="5"  Name="Белорусская"/>
    <row LineID="6"  Name="Беляево"/>
    <row LineID="9"  Name="Бибирево"/>
    <row LineID="1"  Name="Библиотека им. Ленина"/>
    <row LineID="12" Name="Битцевский парк"/>
    <row LineID="12" Name="Лесопарковая"/>
    <row LineID="10" Name="Борисово"/>
    <row LineID="9"  Name="Боровицкая"/>
    <row LineID="6"  Name="Ботанический сад"/>
    <row LineID="10" Name="Братиславская"/>
    <row LineID="12" Name="Бульвар Адмирала Ушакова"/>
    <row LineID="9"  Name="Бульвар Дмитрия Донского"/>
    <row LineID="1"  Name="Бульвар Рокоссовского"/>
    <row LineID="12" Name="Бунинская Аллея"/>
    <row LineID="11" Name="Варшавская"/>
    <row LineID="6"  Name="ВДНХ"/>
    <row LineID="9"  Name="Владыкино"/>
    <row LineID="2"  Name="Водный стадион"/>
    <row LineID="2"  Name="Войковская"/>
    <row LineID="7"  Name="Волгоградский проспект"/>
    <row LineID="10" Name="Волжская"/>
    <row LineID="3"  Name="Волоколамская"/>
    <row LineID="1"  Name="Воробьёвы горы"/>
    <row LineID="4"  Name="Выставочная"/>
    <row LineID="7"  Name="Выхино"/>
    <row LineID="7"  Name="Лермонтовский проспект"/>
    <row LineID="8"  Name="Деловой центр"/>
    <row LineID="2"  Name="Динамо"/>
    <row LineID="9"  Name="Дмитровская"/>
    <row LineID="5"  Name="Добрынинская"/>
    <row LineID="2"  Name="Домодедовская"/>
    <row LineID="10" Name="Достоевская"/>
    <row LineID="10" Name="Дубровка"/>
    <row LineID="10" Name="Зябликово"/>
    <row LineID="3"  Name="Измайловская"/>
    <row LineID="6"  Name="Калужская"/>
    <row LineID="2"  Name="Кантемировская"/>
    <row LineID="11" Name="Каховская"/>
    <row LineID="2"  Name="Каширская"/>
    <row LineID="11" Name="Каширская"/>
    <row LineID="3"  Name="Киевская"/>
    <row LineID="4"  Name="Киевская"/>
    <row LineID="5"  Name="Киевская"/>
    <row LineID="6"  Name="Китай-город"/>
    <row LineID="7"  Name="Китай-город"/>
    <row LineID="10" Name="Кожуховская"/>
    <row LineID="2"  Name="Коломенская"/>
    <row LineID="1"  Name="Комсомольская"/>
    <row LineID="5"  Name="Комсомольская"/>
    <row LineID="6"  Name="Коньково"/>
    <row LineID="2"  Name="Красногвардейская"/>
    <row LineID="5"  Name="Краснопресненская"/>
    <row LineID="1"  Name="Красносельская"/>
    <row LineID="1"  Name="Красные ворота"/>
    <row LineID="10" Name="Крестьянская застава"/>
    <row LineID="1"  Name="Кропоткинская"/>
    <row LineID="3"  Name="Крылатское"/>
    <row LineID="7"  Name="Кузнецкий мост"/>
    <row LineID="7"  Name="Кузьминки"/>
    <row LineID="3"  Name="Кунцевская"/>
    <row LineID="4"  Name="Кунцевская"/>
    <row LineID="3"  Name="Курская"/>
    <row LineID="5"  Name="Курская"/>
    <row LineID="4"  Name="Кутузовская"/>
    <row LineID="6"  Name="Ленинский проспект"/>
    <row LineID="1"  Name="Лубянка"/>
    <row LineID="10" Name="Люблино"/>
    <row LineID="8"  Name="Марксистская"/>
    <row LineID="10" Name="Марьина роща"/>
    <row LineID="10" Name="Марьино"/>
    <row LineID="1"  Name="Маяковская"/>
    <row LineID="6"  Name="Медведково"/>
    <row LineID="4"  Name="Международная"/>
    <row LineID="19" Name="Менделеевская"/>
    <row LineID="3"  Name="Митино"/>
    <row LineID="3"  Name="Молодежная"/>
    <row LineID="3"  Name="Мякинино"/>
    <row LineID="9"  Name="Нагатинская"/>
    <row LineID="9"  Name="Нагорная"/>
    <row LineID="9"  Name="Нахимовский проспект"/>
    <row LineID="8"  Name="Новогиреево"/>
    <row LineID="8"  Name="Новокосино"/>
    <row LineID="2"  Name="Новокузнецкая"/>
    <row LineID="1"  Name="Новопеределкино"/>
    <row LineID="5"  Name="Новослободская"/>
    <row LineID="6"  Name="Новоясеневская"/>
    <row LineID="6"  Name="Новые Черёмушки"/>
    <row LineID="5"  Name="Октябрьская"/>
    <row LineID="6"  Name="Октябрьская"/>
    <row LineID="7"  Name="Октябрьское поле"/>
    <row LineID="1"  Name="Олимпийская Деревня"/>
    <row LineID="2"  Name="Орехово"/>
    <row LineID="9"  Name="Отрадное"/>
    <row LineID="1"  Name="Охотный ряд"/>
    <row LineID="2"  Name="Павелецкая"/>
    <row LineID="5"  Name="Павелецкая"/>
    <row LineID="1"  Name="Парк Культуры"/>
    <row LineID="5"  Name="Парк Культуры"/>
    <row LineID="3"  Name="Парк Победы"/>
    <row LineID="8"  Name="Парк Победы"/>
    <row LineID="3"  Name="Партизанская"/>
    <row LineID="3"  Name="Первомайская"/>
    <row LineID="8"  Name="Перово"/>
    <row LineID="9"  Name="Петровско-Разумовская"/>
    <row LineID="10" Name="Печатники"/>
    <row LineID="4"  Name="Пионерская"/>
    <row LineID="7"  Name="Планерная"/>
    <row LineID="8"  Name="Площадь Ильича"/>
    <row LineID="3"  Name="Площадь Революции"/>
    <row LineID="7"  Name="Полежаевская"/>
    <row LineID="9"  Name="Полянка"/>
    <row LineID="9"  Name="Пражская"/>
    <row LineID="1"  Name="Преображенская площадь"/>
    <row LineID="7"  Name="Пролетарская"/>
    <row LineID="1"  Name="Проспект Вернадского"/>
    <row LineID="5"  Name="Проспект Мира"/>
    <row LineID="6"  Name="Проспект Мира"/>
    <row LineID="6"  Name="Профсоюзная"/>
    <row LineID="7"  Name="Пушкинская"/>
    <row LineID="3"  Name="Пятницкое шоссе"/>
    <row LineID="2"  Name="Речной вокзал"/>
    <row LineID="6"  Name="Рижская"/>
    <row LineID="10" Name="Римская"/>
    <row LineID="7"  Name="Рязанский проспект"/>
    <row LineID="9"  Name="Савёловская"/>
    <row LineID="6"  Name="Свиблово"/>
    <row LineID="9"  Name="Севастопольская"/>
    <row LineID="3"  Name="Семёновская"/>
    <row LineID="9"  Name="Серпуховская"/>
    <row LineID="3"  Name="Славянский бульвар"/>
    <row LineID="3"  Name="Смоленская"/>
    <row LineID="4"  Name="Смоленская"/>
    <row LineID="2"  Name="Сокол"/>
    <row LineID="1"  Name="Сокольники"/>
    <row LineID="1"  Name="Спортивная"/>
    <row LineID="10" Name="Сретенский бульвар"/>
    <row LineID="3"  Name="Строгино"/>
    <row LineID="4"  Name="Студенческая"/>
    <row LineID="6"  Name="Сухаревская"/>
    <row LineID="7"  Name="Сходненская"/>
    <row LineID="5"  Name="Таганская"/>
    <row LineID="7"  Name="Таганская"/>
    <row LineID="7"  Name="Спартак"/>
    <row LineID="2"  Name="Тверская"/>
    <row LineID="2"  Name="Театральная"/>
    <row LineID="7"  Name="Текстильщики"/>
    <row LineID="6"  Name="Теплый стан"/>
    <row LineID="9"  Name="Тимирязевская"/>
    <row LineID="6"  Name="Третьяковская"/>
    <row LineID="8"  Name="Третьяковская"/>
    <row LineID="10" Name="Трубная"/>
    <row LineID="9"  Name="Тульская"/>
    <row LineID="6"  Name="Тургеневская"/>
    <row LineID="7"  Name="Тушинская"/>
    <row LineID="7"  Name="Улица 1905 года"/>
    <row LineID="9"  Name="Улица Академика Янгеля"/>
    <row LineID="12" Name="Улица Горчакова"/>
    <row LineID="12" Name="Улица Скобелевская"/>
    <row LineID="12" Name="Улица Старокачаловская"/>
    <row LineID="1"  Name="Университет"/>
    <row LineID="4"  Name="Филёвский парк"/>
    <row LineID="4"  Name="Фили"/>
    <row LineID="1"  Name="Фрунзенская"/>
    <row LineID="2"  Name="Царицыно"/>
    <row LineID="9"  Name="Цветной бульвар"/>
    <row LineID="1"  Name="Черкизовская"/>
    <row LineID="9"  Name="Чертановская"/>
    <row LineID="9"  Name="Чеховская"/>
    <row LineID="1"  Name="Чистые пруды"/>
    <row LineID="10" Name="Чкаловская"/>
    <row LineID="6"  Name="Шаболовская"/>
    <row LineID="10" Name="Шипиловская"/>
    <row LineID="8"  Name="Шоссе Энтузиастов"/>
    <row LineID="3"  Name="Щёлковская"/>
    <row LineID="7"  Name="Щукинская"/>
    <row LineID="3"  Name="Электрозаводская"/>
    <row LineID="1"  Name="Юго-Западная"/>
    <row LineID="1"  Name="Тропарево"/>
    <row LineID="9"  Name="Южная"/>
    <row LineID="6"  Name="Ясенево"/>
  </Root>'

exec sp_xml_preparedocument @idoc output, @LineXML
declare @Lines table (
     [ID]        int 
    ,[Name]      varchar(256) 
    ,[ColorRGB]  varchar(6) 
    ,[ColorName] varchar(32)
    ,primary key(ID))

insert into @Lines ( 
   [ID]
  ,[Name]
  ,[ColorRGB]
  ,[ColorName])
select
     [ID]
    ,[Name]
    ,[ColorRGB]
    ,[ColorName]
  from openxml(@idoc, '/Root/row', 1)
  with (
     [ID]      int
    ,[Name]    varchar(256) 
    ,ColorRGB  varchar(6) 
    ,ColorName varchar(32))

exec sp_xml_removedocument @idoc
set @idoc = null


exec sp_xml_preparedocument @idoc output, @StationXML
declare @Station table (
     [LineID]  int 
    ,[Name]    varchar(256))

insert into @Station ( 
   [LineID]
  ,[Name])
select
     [LineID]
    ,[Name]
  from openxml(@idoc, '/Root/row', 1)
  with (    
     [LineID] int
    ,[Name]   varchar(256))

exec sp_xml_removedocument @idoc
set @idoc = null

select
     [Station.Name]     = t.Name
    ,[LineID.Name]      = s.Name
    ,[LineID.ColorRGB]  = s.ColorRGB
    ,[LineID.ColorName] = s.ColorName
    ,[Station.DualName] = concat(t.Name, ' (', s.Name, ')')
    ,[Station.FullName] = iif(r.Cnt > 1, concat(t.Name, ' (', s.Name, ')'), t.Name)
  from @Station as t
  join @Lines   as s on s.ID = t.LineID
  outer apply (
    select
         count(*) as Cnt
      from @Station as r
      where r.name = t.name
  ) as r
