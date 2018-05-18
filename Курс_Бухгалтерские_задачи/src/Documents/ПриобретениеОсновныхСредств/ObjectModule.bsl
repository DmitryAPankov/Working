
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр Проводки 
	Движения.Проводки.Записывать = Истина;
	Для Каждого ТекСтрокаОсновныеСредства Из ОсновныеСредства Цикл
		Движение = Движения.Проводки.Добавить();
		Движение.СчетДт = ПланыСчетов.Бухгалтерский.НайтиПоКоду("1.6.1");
		БухгалтерияСервер.УстановитьСубконто(Движение.СчетДт, Движение.СубконтоДт, 1, ТекСтрокаОсновныеСредства.ОсновноеСредство);
		Движение.СчетКт = ПланыСчетов.Бухгалтерский.Поставщики;
		Движение.Период = Дата;
		Движение.Организация = Организация;
		Движение.ПодразделениеДт = Подразделение;
		Движение.ПодразделениеКт = Подразделение;
		Движение.Сумма = ТекСтрокаОсновныеСредства.Сумма;
		Движение.Содержание = "ПриобретениеОС";
		Движение.СубконтоКт[ПланыВидовХарактеристик.ВидыСубконто.Контрагенты] = Поставщик;
		Движение.СубконтоКт[ПланыВидовХарактеристик.ВидыСубконто.Договоры] = Договор;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
