﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

// контекст фреймворка Vanessa-ADD
Перем Ванесса;

// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

	// описание шагов
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"СуществуетДокументСКодом(Парам01,Парам02)","СуществуетДокументСКодом","Когда Существует документ ""Документ1"" с кодом ""000000001""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиПодменюСИменем(Парам01,Парам02,Парам03,Парам04,Парам05)","ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиПодменюСИменем","Тогда В форме документа ""Документ1"" с номером ""000000001"" интерактивно нажимаю кнопку панели ""ДействияФормы"" подменю ""Подменю"" с именем ""Действие1""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиСИменем(Парам01,Парам02,Парам03,Парам04)","ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиСИменем","Тогда В форме документа ""Документ1"" с номером ""000000001"" интерактивно нажимаю кнопку панели ""ДействияФормы"" с именем ""Действие1""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"СуществуетЭлементСправочникаСКодом(Парам01,Парам02)","СуществуетЭлементСправочникаСКодом","Когда Существует элемент справочника ""Справочник2"" с кодом ""000000001""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВФормеЭлементаСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиПодменюСИменем(Парам01,Парам02,Парам03,Парам04,Парам05)","ВФормеЭлементаСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиПодменюСИменем","Тогда В форме элемента справочника ""Справочник2"" с кодом ""000000001"" интерактивно нажимаю кнопку панели ""ДействияФормы"" подменю ""Подменю"" с именем ""Действие1""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВФормеЭлементаСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиСИменем(Парам01,Парам02,Парам03,Парам04)","ВФормеЭлементаСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиСИменем","Тогда В форме элемента справочника ""Справочник2"" с кодом ""000000001"" интерактивно нажимаю кнопку панели ""ДействияФормы"" с именем ""Действие1""");

	Возврат ВсеТесты;
КонецФункции

// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакет(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт

КонецПроцедуры

// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт

КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

//Когда Существует документ "Документ1" с кодом "000000001"
//@СуществуетДокументСКодом(Парам01,Парам02)
Процедура СуществуетДокументСКодом(ИмяДокумента,НомерДокумента) Экспорт
	НайденнаяСсылка = НайтиДокументПоНомеру(ИмяДокумента, НомерДокумента);
	Если Не ЗначениеЗаполнено(НайденнаяСсылка) Тогда
		СоздатьДокумент(ИмяДокумента, НомерДокумента);
		НайденнаяСсылка = НайтиДокументПоНомеру(ИмяДокумента, НомерДокумента);
	КонецЕсли;

	Ванесса.ПроверитьНеРавенство(ЗначениеЗаполнено(НайденнаяСсылка),Ложь);
КонецПроцедуры

Процедура СоздатьДокумент(ИмяДокумента,НомерДокумента)

	ДокументОбъект 						= Документы[ИмяДокумента].СоздатьДокумент();
	ДокументОбъект.Номер		 		= НомерДокумента;
	ДокументОбъект.Дата		  			= ТекущаяДата();
	ДокументОбъект.ОбменДанными.Загрузка  = Истина;
	ДокументОбъект.Записать();

КонецПроцедуры

//Когда Существует элемент справочника "Справочник2" с кодом "000000001"
//@СуществуетЭлементСправочникаСКодом(Парам01,Парам02)
Процедура СуществуетЭлементСправочникаСКодом(ИмяСправочника,КодСправочника) Экспорт

	НайденнаяСсылка = НайтиСправочникПоКоду(ИмяСправочника, КодСправочника);
	Если Не ЗначениеЗаполнено(НайденнаяСсылка) Тогда
		СоздатьЭлементСправочника(ИмяСправочника,КодСправочника);
		НайденнаяСсылка = НайтиСправочникПоКоду(ИмяСправочника, КодСправочника);
	КонецЕсли;

	Ванесса.ПроверитьНеРавенство(ЗначениеЗаполнено(НайденнаяСсылка),Ложь);

КонецПроцедуры

Процедура СоздатьЭлементСправочника(ИмяСправочника,КодСправочника)

	СправочникОбъект 						= Справочники[ИмяСправочника].СоздатьЭлемент();
	СправочникОбъект.Наименование 			= ИмяСправочника+" код: "+КодСправочника;
	СправочникОбъект.Код		  			= КодСправочника;
	СправочникОбъект.ОбменДанными.Загрузка  = Истина;
	СправочникОбъект.Записать();

КонецПроцедуры

//Когда В форме документа "ПрочиеЗатраты" с номером "АГ000000001" интерактивно нажимаю кнопку панели "ДействияФормы" подменю "Подменю" с именем "Действие6"
//@ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиПодменюСИменем(Парам01,Парам02,Парам03,Парам04,Парам05)
Процедура ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиПодменюСИменем(ИмяДокумента,НомерДокумента,ИмяПанели,ИмяПодменю,ИмяКнопки) Экспорт
	НайденаСсылка  = НайтиДокументПоНомеру(ИмяДокумента, НомерДокумента);
	ПроизвестиНажатиеВФормеИЗакрыть(НайденаСсылка, "ФормаДокумента", ИмяПанели, ИмяКнопки,  ИмяПодменю);
КонецПроцедуры

//Когда В форме документа "ПрочиеЗатраты" с номером "АГ000000001" интерактивно нажимаю кнопку панели "ДействияФормы" с именем "Действие1"
//@ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиСИменем(Парам01,Парам02,Парам03,Парам04)
Процедура ВФормеДокументаСНомеромИнтерактивноНажимаюКнопкуПанелиСИменем(ИмяДокумента, НомерДокумента, ИмяПанели, ИмяКнопки) Экспорт
	НайденаСсылка  = НайтиДокументПоНомеру(ИмяДокумента, НомерДокумента);
	ПроизвестиНажатиеВФормеИЗакрыть(НайденаСсылка, "ФормаДокумента", ИмяПанели, ИмяКнопки);
КонецПроцедуры

Процедура ПроизвестиНажатиеВФормеИЗакрыть(Ссылка, ИмяФормы, ИмяПанели, ИмяКнопки,  ИмяПодменю="")

	Если Не ЗначениеЗаполнено(Ссылка) Тогда
		ВызватьИсключение "Не возможно открыть форму абстрактного объекта, укажите ссылку";
	КонецЕсли;
	ФормаОбъекта = Ссылка.ПолучитьФорму(ИмяФормы);
	Если ЗначениеЗаполнено(ИмяПодменю) Тогда
		ИнтерактивноНажатьКнопку(ФормаОбъекта.ЭлементыФормы[ИмяПанели].Кнопки[ИмяПодменю].Кнопки[ИмяКнопки],ФормаОбъекта);
	Иначе
		ИнтерактивноНажатьКнопку(ФормаОбъекта.ЭлементыФормы[ИмяПанели].Кнопки[ИмяКнопки],ФормаОбъекта);
	КонецЕсли;

	Если ФормаОбъекта.Открыта() Тогда
		ФормаОбъекта.Закрыть();
	КонецЕсли;
КонецПроцедуры

Функция НайтиДокументПоНомеру(ИмяДокумента, НомерДокумента)

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ИмяДокумента.Ссылка
		|ИЗ
		|	Документ."+ИмяДокумента+" КАК ИмяДокумента
		|ГДЕ
		|	ИмяДокумента.Номер = &Номер";

	Запрос.УстановитьПараметр("Номер", НомерДокумента);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

Функция НайтиСправочникПоКоду(ИмяСправочника, КодСправочника)

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ИмяСправочника.Ссылка
		|ИЗ
		|	Справочник."+ИмяСправочника+" КАК ИмяСправочника
		|ГДЕ
		|	ИмяСправочника.Код = &Код";

	Запрос.УстановитьПараметр("Код", КодСправочника);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	КонецЕсли;

	Возврат Неопределено;

КонецФункции

Процедура ИнтерактивноНажатьКнопку(Кнопка, ФормаКнопки) Экспорт
    // Удостоверимся что есть права на нажатие
    // Кнопка
    стрОшибка = "";
    Попытка
        Если Кнопка.Видимость = Ложь Тогда
            стрОшибка = стрОшибка + ", Невидима";
        КонецЕсли;
    Исключение
    КонецПопытки;
    Попытка
        Если Кнопка.Доступность = Ложь Тогда
            стрОшибка = стрОшибка + ", Недоступна";
        КонецЕсли;
    Исключение
    КонецПопытки;
    Если стрОшибка <> "" Тогда
        стрОшибка = Сред(стрОшибка, 3)+" кнопка, которую требуется нажать";
        ВызватьИсключение(стрОшибка);
    КонецЕсли;

    Если ТипЗнч(Кнопка) = Тип("КнопкаКоманднойПанели") Тогда
        Действие = Кнопка.Действие;
    ИначеЕсли ТипЗнч(Кнопка) = Тип("Кнопка") Тогда
        Действие = Кнопка.ПолучитьДействие("Нажатие");
    КонецЕсли;
    буфДействие = ФормаКнопки.ПолучитьДействие("ПриПовторномОткрытии");
    ФормаКнопки.УстановитьДействие("ПриПовторномОткрытии", Действие);
    Попытка
        // собственно вызов нажатия кнопки
        ФормаКнопки.Открыть();
        ФормаКнопки.УстановитьДействие("ПриПовторномОткрытии", буфДействие);
    Исключение
        ФормаКнопки.УстановитьДействие("ПриПовторномОткрытии", буфДействие);
        ВызватьИсключение;
    КонецПопытки;
КонецПроцедуры

//Когда В форме элемента справочника "Номенклатура" с кодом "NSIN0000982023" интерактивно нажимаю кнопку панели "ДействияФормы" подменю "Подменю" с именем "Действие1"
//@ВФормеСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиПодменюСИменем(Парам01,Парам02,Парам03,Парам04,Парам05)
Процедура ВФормеЭлементаСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиПодменюСИменем(ИмяСправочника,КодСправочника,ИмяПанели,ИмяПодменю,ИмяКнопки) Экспорт
	НайденаСсылка  = НайтиСправочникПоКоду(ИмяСправочника, КодСправочника);
	ПроизвестиНажатиеВФормеИЗакрыть(НайденаСсылка, "ФормаЭлемента", ИмяПанели, ИмяКнопки,  ИмяПодменю);
КонецПроцедуры

//Когда В форме элемента справочника "Номенклатура" с кодом "NSIN0000982023" интерактивно нажимаю кнопку панели "ДействияФормы" с именем "Настройка"
//@ВФормеСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиСИменем(Парам01,Парам02,Парам03,Парам04)
Процедура ВФормеЭлементаСправочникаСКодомИнтерактивноНажимаюКнопкуПанелиСИменем(ИмяСправочника,КодСправочника,ИмяПанели,ИмяКнопки) Экспорт
	НайденаСсылка  = НайтиСправочникПоКоду(ИмяСправочника, КодСправочника);
	ПроизвестиНажатиеВФормеИЗакрыть(НайденаСсылка, "ФормаЭлемента", ИмяПанели, ИмяКнопки);
КонецПроцедуры
