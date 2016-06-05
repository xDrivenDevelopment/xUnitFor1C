﻿
// { Plugin interface
&НаКлиенте
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Возврат ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов);
КонецФункции

&НаСервере
Функция ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов)
	Возврат ЭтотОбъектНаСервере().ОписаниеПлагина(ВозможныеТипыПлагинов);
КонецФункции
// } Plugin interface

// { Loader interface
&НаКлиенте
Функция ВыбратьПутьИнтерактивно(ТекущийПуть = "") Экспорт
	ДиалогВыбораКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбораКаталога.Каталог = ТекущийПуть;
	
	Результат = "";
	Если ДиалогВыбораКаталога.Выбрать() Тогда
		Результат = ДиалогВыбораКаталога.Каталог;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция Загрузить(КонтекстЯдра, Путь) Экспорт
	КаталогДляЗагрузки = Новый Файл(Путь);
	Если Не (КаталогДляЗагрузки.Существует() И КаталогДляЗагрузки.ЭтоКаталог()) Тогда
		ВызватьИсключение "Для загрузки передан не каталог файловой системы <" + КаталогДляЗагрузки.ПолноеИмя + ">";
	КонецЕсли;
	ДеревоТестов = ЗагрузитьКаталог(КонтекстЯдра, КаталогДляЗагрузки);
	ДеревоТестов.Имя = КаталогДляЗагрузки.ПолноеИмя;
	
	Возврат ДеревоТестов;
КонецФункции

&НаКлиенте
Функция ПолучитьКонтекстПоПути(КонтекстЯдра, Путь) Экспорт
	ЗагрузчикФайла = КонтекстЯдра.Плагин("ЗагрузчикФайла");
	Контекст = ЗагрузчикФайла.ПолучитьКонтекстПоПути(КонтекстЯдра, Путь);
	
	Возврат Контекст;
КонецФункции
// } Loader interface

&НаКлиенте
Функция ЗагрузитьКаталог(КонтекстЯдра, КаталогДляЗагрузки)
	КонтейнерКаталога = КонтекстЯдра.Плагин("ПостроительДереваТестов").СоздатьКонтейнер(КаталогДляЗагрузки.Имя);
	НайденныеФайлы = НайтиФайлы(КаталогДляЗагрузки.ПолноеИмя, "*", Ложь);
	Для каждого Файл из НайденныеФайлы Цикл
		ОбработкаПрерыванияПользователя();
		Если Файл.ЭтоКаталог() Тогда
			КонтейнерДочернегоКаталога = ЗагрузитьКаталог(КонтекстЯдра, Файл);
			Если КонтейнерДочернегоКаталога.Строки.Количество() > 0 Тогда
				КонтейнерКаталога.Строки.Добавить(КонтейнерДочернегоКаталога);
			КонецЕсли;
		ИначеЕсли НРег(Файл.Расширение) = ".epf" Тогда
			КонтейнерФайла = ЗагрузитьФайл(КонтекстЯдра, Файл);
			Если ЗначениеЗаполнено(КонтейнерФайла) И КонтейнерФайла.Строки.Количество() > 0 Тогда
				КонтейнерКаталога.Строки.Добавить(КонтейнерФайла);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат КонтейнерКаталога;
КонецФункции

&НаКлиенте
Функция ЗагрузитьФайл(КонтекстЯдра, ФайлОбработки)
	ЗагрузчикФайла = КонтекстЯдра.Плагин("ЗагрузчикФайла");
	Попытка
		ДеревоТестовФайла = ЗагрузчикФайла.Загрузить(КонтекстЯдра, ФайлОбработки.ПолноеИмя);
		Результат = ДеревоТестовФайла;
		Если ДеревоТестовФайла.Строки.Количество() > 0 Тогда
			Результат = ДеревоТестовФайла.Строки[0];
		КонецЕсли;
		
	Исключение
		Сообщить("Не удалось загрузить файл " + ФайлОбработки.ПолноеИмя + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		Результат = Неопределено;
	КонецПопытки;
	
	Возврат Результат;
КонецФункции

// { Helpers
&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
// } Helpers
