
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если Не ЭтоНовый() И Ссылка.ПометкаУдаления <> ПометкаУдаления Тогда
		Движения.Проводки.Записывать = Истина;
		Движения.Проводки.Прочитать();
		Движения.Проводки.УстановитьАктивность(НЕ ПометкаУдаления);			
	КонецЕсли;
	
	
	Если НЕ Движения.Проводки.Количество() = 0  Тогда
		Для каждого Проводка Из Движения.Проводки Цикл
			Проводка.Период = Дата;
			Проводка.Организация = Организация;
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	ОбъектКопирования.Движения.Проводки.Прочитать();
	Для каждого ИсхЗапись Из ОбъектКопирования.Движения.Проводки Цикл
		Проводка = Движения.Проводки.Добавить();
		ЗаполнитьЗначенияСвойств(Проводка, ИсхЗапись);
	КонецЦикла;
КонецПроцедуры
