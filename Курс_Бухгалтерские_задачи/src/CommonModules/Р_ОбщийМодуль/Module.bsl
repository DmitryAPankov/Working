Функция ПроверитьВремТаб(МенеджерВремТаб,ИмяВремтаб ="",Порядок = "") Экспорт

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВремТаб;
	Запрос.Текст =
	"ВЫБРАТЬ
	| *
	|ИЗ
	| ВремТаб КАК ВремТаб
	|
	|УПОРЯДОЧИТЬ ПО Порядок";

	Запрос.Текст = СтрЗаменить(Запрос.Текст,"ВремТаб",ИмяВремтаб); 
	Если Порядок = "" тогда 
	    Запрос.Текст = СтрЗаменить(Запрос.Текст,"УПОРЯДОЧИТЬ ПО Порядок","");
	Иначе 
	    Запрос.Текст = СтрЗаменить(Запрос.Текст,"Порядок",Порядок);
	КонецЕсли; 

	ТЗ = Запрос.Выполнить().Выгрузить(); 

	Возврат ТЗ; 
	
КонецФункции