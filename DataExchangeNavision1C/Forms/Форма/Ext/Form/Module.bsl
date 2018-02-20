﻿
&НаКлиенте
Процедура Запуск(Команда)
	
	
	//Элементы.Индикатор.МаксимальноеЗначение = 100;
	ЗапускНаСервере();
    ПодключитьОбработчикОжидания("ПроверитьВыполнениеЗадания", 1);
	
КонецПроцедуры

&НаСервере
Процедура ЗапускНаСервере()
    ФоновоеЗадание = ФоновыеЗадания.Выполнить("ОбщийМодульШатеМ.Тестовая"); 
    Идентификатор = ФоновоеЗадание.УникальныйИдентификатор; // Идентификатор - реквизит формы с типом уникальный идентификатор
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыполнениеЗадания()
	
    Сообщения = ПолучитьСообщения();
    Если Сообщения = "Выполнено" Тогда
        ОтключитьОбработчикОжидания("ПроверитьВыполнениеЗадания");
		//Состояние("Выполнено:", 100);
    Иначе
		Для Каждого ЭлементСообщение Из Сообщения Цикл
			
			//Состояние("Выполнено:", Число(ЭлементСообщение.Текст), "какое-то пояснение",);
			Сообщить((ЭлементСообщение.Текст));
			
			Индикатор = Число(ЭлементСообщение.Текст);			
			Элементы.Индикатор.Заголовок = ЭлементСообщение.Текст + "%"; 
			
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьСообщения()
	
    Задание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(Идентификатор);   
    Если Задание.Состояние = СостояниеФоновогоЗадания.Активно Тогда
        Возврат Задание.ПолучитьСообщенияПользователю(Истина);
    Иначе
        Возврат "Выполнено";
	КонецЕсли;
	
КонецФункции



