
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
движения.Проводки.Записать();

//Блокировка: организация, Счет=товары
Блокировка = Новый БлокировкаДанных;
ЭлементБД = Блокировка.Добавить("РегистрБухгалтерии.Проводки");
ЭлементБД.УстановитьЗначение("Счет", ПланыСчетов.Бухгалтерский.Товары);
ЭлементБД.УстановитьЗначение("Организация", Организация);
ЭлементБД.Режим = РежимБлокировкиДанных.Исключительный;
Блокировка.Заблокировать();	

//запрос

Запрос = Новый Запрос;
ВидыСубконтоНС = Новый Массив;
ВидыСубконтоНС.Добавить(ПланыВидовХарактеристик.ВидыСубконто.Номенклатура);
ВидыСубконтоНС.Добавить(ПланыВидовХарактеристик.ВидыСубконто.Склады);
Запрос.УстановитьПараметр("ВидыСубконтоНС", ВидыСубконтоНС);
Запрос.УстановитьПараметр("НачМесяца", НачалоМесяца(Дата));
Запрос.УстановитьПараметр("КонМесяца", КонецМесяца(Дата));
Запрос.УстановитьПараметр("Организация", Организация);

Запрос.Текст = 
"ВЫБРАТЬ
|	ОстИОб.Субконто1 КАК Номенклатура,
|	ОстИОб.Субконто2 КАК Склад,
|	ОстИОб.Подразделение КАК Подразделение,
|	(ВЫРАЗИТЬ(ВЫБОР
|			КОГДА ОстИОб.КоличествоНачальныйОстаток + ОстИОб.КоличествоОборотДт = 0
|				ТОГДА 0
|			ИНАЧЕ (ОстИОб.СуммаНачальныйОстаток + ОстИОб.СуммаОборотДт) / (ОстИОб.КоличествоНачальныйОстаток + ОстИОб.КоличествоОборотДт)
|		КОНЕЦ КАК ЧИСЛО(15, 2))) * ОстИОб.КоличествоОборотКт - ОстИОб.СуммаОборотКт КАК Разница
|ИЗ
|	РегистрБухгалтерии.Проводки.ОстаткиИОбороты(&НачМесяца, &КонМесяца, , , Счет = ЗНАЧЕНИЕ(ПланСчетов.Бухгалтерский.Товары), &ВидыСубконтоНС, Организация = &Организация) КАК ОстИОб
|ГДЕ
|	(ВЫРАЗИТЬ(ВЫБОР
|				КОГДА ОстИОб.КоличествоНачальныйОстаток + ОстИОб.КоличествоОборотДт = 0
|					ТОГДА 0
|				ИНАЧЕ (ОстИОб.СуммаНачальныйОстаток + ОстИОб.СуммаОборотДт) / (ОстИОб.КоличествоНачальныйОстаток + ОстИОб.КоличествоОборотДт)
|			КОНЕЦ КАК ЧИСЛО(15, 2))) * ОстИОб.КоличествоОборотКт - ОстИОб.СуммаОборотКт <> 0";

Результат = Запрос.Выполнить();

Выборка = Результат.Выбрать();

Движения.Проводки.Записывать = Истина;

Пока Выборка.Следующий() Цикл

//можно рассчитать себестоимость

Движение = Движения.Проводки.Добавить();
Движение.СчетДт = ПланыСчетов.Бухгалтерский.Капитал;
Движение.СчетКт = ПланыСчетов.Бухгалтерский.Товары;
БухгалтерияСервер.УстановитьСубконто(Движение.СчетКт, Движение.СубконтоКт, "Номенклатура", Выборка.Номенклатура);
БухгалтерияСервер.УстановитьСубконто(Движение.СчетКт, Движение.СубконтоКт, "Склады", Выборка.Склад);

Движение.Период = Дата;
Движение.Сумма = Выборка.Разница;
//Движение.КоличествоКт = Выборка.Количество;
Движение.Содержание = "стоимость";
Движение.Организация = Организация;
БухгалтерияСервер.УстановитьПодразделенияПроводки(Движение, Выборка.Подразделение, Выборка.Подразделение);


КонецЦикла;

КонецПроцедуры
