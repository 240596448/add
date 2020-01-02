﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-ADD
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;

&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-ADD.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

	// описание шагов
	// пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты, Снипет, ИмяПроцедуры, ПредставлениеТеста, ОписаниеШага, ТипШагаДляОписания, ТипШагаВДереве);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСписке(ТабПарам)","ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСписке","И для каждой строки таблицы отбора я устанавливаю отбор в списке","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСпискеЕслиЭтоВозможно(ТабПарам)","ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСпискеЕслиЭтоВозможно","И для каждой строки таблицы отбора я устанавливаю отбор в списке если это возможно","","");

	Возврат ВсеТесты;
КонецФункции

&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции

&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт

КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт

КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И для каждой строки таблицы отбора я устанавливаю отбор в списке
//@ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСписке(ТабПарам)
Процедура ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСписке(ТабПарам,ВызыватьИсключениеЕслиНетТакогоФильтра = Истина) Экспорт

	Для Каждого СтрокаФильтра Из ТабПарам Цикл

		АктивноеОкно           = Ванесса.ПолучитьАктивноеОкноИзТестовоеПриложение();
		ТаблицаНастройкаСписка = АктивноеОкно.НайтиОбъект(Тип("ТестируемаяТаблицаФормы"),,"КомпоновщикНастроекПользовательскиеНастройкиЭлемент*ДоступныеПоляТаблица");

		ОписаниеСтроки = Новый Соответствие;
		ОписаниеСтроки.Вставить("Доступные поля",СтрокаФильтра.Кол1);
		ТаблицаНастройкаСписка.ПерейтиКПервойСтроке();
		Попытка
			ТаблицаНастройкаСписка.ПерейтиКСтроке(ОписаниеСтроки,Вычислить("НаправлениеПереходаКСтроке.Вниз"),Ложь);
		Исключение
			Если ВызыватьИсключениеЕслиНетТакогоФильтра Тогда
				ВызватьИсключение ОписаниеОшибки();
			Иначе
				Продолжить;
			КонецЕсли;
		КонецПопытки;


		ТекущийТекстЯчейки = ТаблицаНастройкаСписка.ПолучитьТекстЯчейки();
		Если ТекущийТекстЯчейки <> СтрокаФильтра.Кол1 Тогда
			//Значит не получилось перейти к нужной строке.
			//Но почему-то в этом окне не вызвалось исключение
			Если ВызыватьИсключениеЕслиНетТакогоФильтра Тогда
				ВызватьИсключение "Не смог перейти к строке фильтра <" + СтрокаФильтра.Кол1 + ">";
			Иначе
				Продолжить;
			КонецЕсли;
		КонецЕсли;

		ТЧ = АктивноеОкно.НайтиОбъект(Тип("ТестируемаяТаблицаФормы"),,"КомпоновщикНастроекПользовательскиеНастройкиЭлемент*Отбор");
		Кнопка = АктивноеОкно.НайтиОбъект(Тип("ТестируемаяКнопкаФормы"),,"КомпоновщикНастроекПользовательскиеНастройкиЭлемент*ДоступныеПоляВыбрать");
		Кнопка.Нажать();

		ЗакладкаОтбор = АктивноеОкно.НайтиОбъект(Тип("ТестируемаяГруппаФормы"),"Отбор");
		ЗакладкаОтбор.Активизировать();

		ТЧ.Активизировать();
		ПолеВидСравнения  = ТЧ.НайтиОбъект(Тип("ТестируемоеПолеФормы"),,"КомпоновщикНастроекПользовательскиеНастройкиЭлемент*ОтборВидСравнения");
		ПолеВидСравнения.Активизировать();

		//в Web не сработало ТЧ.ПолучитьТекстЯчейки("КомпоновщикНастроекПользовательскиеНастройкиЭлемент*ОтборВидСравнения");
		ВидСравненияТекст = ТЧ.ПолучитьТекстЯчейки();

		ПолеЗначение = ТЧ.НайтиОбъект(Тип("ТестируемоеПолеФормы"),"Значение");

		ПолеЗначение.Активизировать();
		ТЧ.ИзменитьСтроку();
		ПолеЗначение.ВвестиТекст(СтрокаФильтра.Кол3);

		Если НРег(СокрЛП(ВидСравненияТекст)) <> НРег(СокрЛП(СтрокаФильтра.Кол2)) Тогда
			Ванесса.Шаг("И в ТЧ ""КомпоновщикНастроекПользовательскиеНастройкиЭлемент*Отбор"" я активизирую поле ""Вид сравнения""");
			Ванесса.Шаг("И в ТЧ ""КомпоновщикНастроекПользовательскиеНастройкиЭлемент*Отбор"" в поле ""Вид сравнения"" я ввожу текст '" + СтрокаФильтра.Кол2 + "'");
		КонецЕсли;

		ТЧ.ЗакончитьРедактированиеСтроки();

	КонецЦикла;
КонецПроцедуры


&НаКлиенте
//И для каждой строки таблицы отбора я устанавливаю отбор в списке если это возможно
//@ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСпискеЕслиЭтоВозможно(ТабПарам)
Процедура ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСпискеЕслиЭтоВозможно(ТабПарам) Экспорт
	ДляКаждойСтрокиТаблицыОтбораЯУстанавливаюОтборВСписке(ТабПарам,Ложь);
КонецПроцедуры
