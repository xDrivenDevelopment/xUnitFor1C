# xUnitFor1C - Set of testing tools for 1C:Enterprise 8 platform

xUnitFor1C is a set of testing tools for 1C:Enterprise 8 platform (http://v8.1c.ru).

xUnitFor1C - набор инструментов для выполнения тестирования (модульного/юнит, приемочного, сценарного для 1С 8.3, интеграционного) в 1С:Предприятии 8.

[Посмотрите Wiki](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki)

xUnitFor1C - простой и мощный фреймворк для тестирования в 1С.

xUnitFor1C работает с любыми конфигурациями, полностью независима, но может быть встроена в конфигурацию.

Позволяет открывать/тестировать в разных режимах - обычное приложение, тонкий и толстый клиент управляемого приложения. Поддерживаются любые платформы 1С - от 8.2.17 до 8.3.5 и выше.

Для быстрого входа рекомендуем [почитать статьи или посмотреть видео](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A1%D1%82%D0%B0%D1%82%D1%8C%D0%B8-%D0%B8-%D0%B2%D0%B8%D0%B4%D0%B5%D0%BE-%D0%BF%D0%BE-%D1%82%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8E-%D0%B2-1%D0%A1)

Тесты могут быть как во внешних обработках, так и во встроенных обработках. 

Любые наборы тестов могут прогоняться в полностью автоматическом режиме через [специальную командную строку запуска](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%97%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2-%D0%B8%D0%B7-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D0%BD%D0%BE%D0%B9-%D1%81%D1%82%D1%80%D0%BE%D0%BA%D0%B8-%D0%B8-%D0%BF%D0%BE%D0%BB%D1%83%D1%87%D0%B5%D0%BD%D0%B8%D0%B5-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2-%D1%80%D0%B5%D0%B7%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D1%82%D0%BE%D0%B2). Автозапуск используется в различных build-серверах и в системах Continuous Integration.

Также возможно очень простое создание тестовых данных на основании табличных макетов. Эти макеты можно генерировать из реальных боевых данных. Полученные данные в тестах загружаются одной строкой кода.

Почитайте короткую [инструкцию по установке фреймворка xUnitFor1C](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F-%D0%BF%D0%BE-%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B5-%D1%84%D1%80%D0%B5%D0%B9%D0%BC%D0%B2%D0%BE%D1%80%D0%BA%D0%B0-xUnitFor1C)

В случае возникновения каких-то проблем при тестировании рекомендуем заглянуть на страницу [Известные проблемы при тестировании](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%98%D0%B7%D0%B2%D0%B5%D1%81%D1%82%D0%BD%D1%8B%D0%B5-%D0%BF%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC%D1%8B-%D0%BF%D1%80%D0%B8-%D1%82%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B8)

### Использование xUnitFor1C

* [Создание файлов-тестов](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2)

* [Принципы написания тестов](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%9F%D1%80%D0%B8%D0%BD%D1%86%D0%B8%D0%BF%D1%8B-%D0%BD%D0%B0%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D1%8F-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2)

* [Методы проверки/утверждений](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%9C%D0%B5%D1%82%D0%BE%D0%B4%D1%8B-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B8---%D1%83%D1%82%D0%B2%D0%B5%D1%80%D0%B6%D0%B4%D0%B5%D0%BD%D0%B8%D1%8F)

* [Известные проблемы при тестировании](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%98%D0%B7%D0%B2%D0%B5%D1%81%D1%82%D0%BD%D1%8B%D0%B5-%D0%BF%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC%D1%8B-%D0%BF%D1%80%D0%B8-%D1%82%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B8)

* [Тестирование через образец исходных данных](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A2%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%B5%D1%86-%D0%B8%D1%81%D1%85%D0%BE%D0%B4%D0%BD%D1%8B%D1%85-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85)

* [Связанные наборы тестов тестовые сценарии в виде связанных шагов сценария](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A1%D0%B2%D1%8F%D0%B7%D0%B0%D0%BD%D0%BD%D1%8B%D0%B5-%D0%BD%D0%B0%D0%B1%D0%BE%D1%80%D1%8B-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D1%8B%D0%B5-%D1%81%D1%86%D0%B5%D0%BD%D0%B0%D1%80%D0%B8%D0%B8-%D0%B2-%D0%B2%D0%B8%D0%B4%D0%B5-%D1%81%D0%B2%D1%8F%D0%B7%D0%B0%D0%BD%D0%BD%D1%8B%D1%85-%D1%88%D0%B0%D0%B3%D0%BE%D0%B2-%D1%81%D1%86%D0%B5%D0%BD%D0%B0%D1%80%D0%B8%D1%8F)

[Запуск тестов из командной строки и получение файлов результатов](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%97%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2-%D0%B8%D0%B7-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D0%BD%D0%BE%D0%B9-%D1%81%D1%82%D1%80%D0%BE%D0%BA%D0%B8-%D0%B8-%D0%BF%D0%BE%D0%BB%D1%83%D1%87%D0%B5%D0%BD%D0%B8%D0%B5-%D1%84%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2-%D1%80%D0%B5%D0%B7%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D1%82%D0%BE%D0%B2)

* [Запуск тестов на build-серверах Jenkins, TeamCity и т.д.](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%97%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2-%D0%BD%D0%B0-build-%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%B0%D1%85-Jenkins,-TeamCity-%D0%B8-%D1%82.%D0%B4.)

[Генерация данных](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%93%D0%B5%D0%BD%D0%B5%D1%80%D0%B0%D1%86%D0%B8%D1%8F-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85)

* [Режимы генерации данных при создании объектов и поиске реквизитов объектов](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A0%D0%B5%D0%B6%D0%B8%D0%BC%D1%8B-%D0%B3%D0%B5%D0%BD%D0%B5%D1%80%D0%B0%D1%86%D0%B8%D0%B8-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85-%D0%BF%D1%80%D0%B8-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B8-%D0%BE%D0%B1%D1%8A%D0%B5%D0%BA%D1%82%D0%BE%D0%B2-%D0%B8-%D0%BF%D0%BE%D0%B8%D1%81%D0%BA%D0%B5-%D1%80%D0%B5%D0%BA%D0%B2%D0%B8%D0%B7%D0%B8%D1%82%D0%BE%D0%B2-%D0%BE%D0%B1%D1%8A%D0%B5%D0%BA%D1%82%D0%BE%D0%B2)

* [Генерация макета на базе реальных данных](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%93%D0%B5%D0%BD%D0%B5%D1%80%D0%B0%D1%86%D0%B8%D1%8F-%D0%BC%D0%B0%D0%BA%D0%B5%D1%82%D0%B0-%D0%BD%D0%B0-%D0%B1%D0%B0%D0%B7%D0%B5-%D1%80%D0%B5%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D1%85-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85)

* [Создание макета данных на основании результатов запросов (например, через ирМобильные)](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BC%D0%B0%D0%BA%D0%B5%D1%82%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85-%D0%BD%D0%B0-%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B8-%D1%80%D0%B5%D0%B7%D1%83%D0%BB%D1%8C%D1%82%D0%B0%D1%82%D0%BE%D0%B2-%D0%B7%D0%B0%D0%BF%D1%80%D0%BE%D1%81%D0%BE%D0%B2-%28%D0%BD%D0%B0%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%80%2C-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-%D0%B8%D1%80%D0%9C%D0%BE%D0%B1%D0%B8%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5%29)

[Тесты открытия форм](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A2%D0%B5%D1%81%D1%82%D1%8B-%D0%BE%D1%82%D0%BA%D1%80%D1%8B%D1%82%D0%B8%D1%8F-%D1%84%D0%BE%D1%80%D0%BC) (удобно юзать перед выпуском релиза или его установкой на рабочую базу)

Примеры тестов:

* [Пример теста СКД и отчета, сделанного на компоновке](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%9F%D1%80%D0%B8%D0%BC%D0%B5%D1%80-%D1%82%D0%B5%D1%81%D1%82%D0%B0-%D0%A1%D0%9A%D0%94-%D0%B8-%D0%BE%D1%82%D1%87%D0%B5%D1%82%D0%B0%2C-%D1%81%D0%B4%D0%B5%D0%BB%D0%B0%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BD%D0%B0-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%BE%D0%B2%D0%BA%D0%B5)

Скрипт для Snegopat ["Добавить описание тестовых случаев текущего модуля в метод ПолучитьСписокТестов" (xUnitAddTestsDesc.js)](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%A1%D0%BA%D1%80%D0%B8%D0%BF%D1%82-%D0%B4%D0%BB%D1%8F-Snegopat---%D0%94%D0%BE%D0%B1%D0%B0%D0%B2%D0%B8%D1%82%D1%8C-%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D1%8B%D1%85-%D1%81%D0%BB%D1%83%D1%87%D0%B0%D0%B5%D0%B2-%D1%82%D0%B5%D0%BA%D1%83%D1%89%D0%B5%D0%B3%D0%BE-%D0%BC%D0%BE%D0%B4%D1%83%D0%BB%D1%8F-%D0%B2-%D0%BC%D0%B5%D1%82%D0%BE%D0%B4-%D0%9F%D0%BE%D0%BB%D1%83%D1%87%D0%B8%D1%82%D1%8C%D0%A1%D0%BF%D0%B8%D1%81%D0%BE%D0%BA%D0%A2%D0%B5%D1%81%D1%82%D0%BE%D0%B2----xUnitAddTestsDesc.js)

**[Инструкция для контрибьюторов, т.е. для тех, кто жаждет доработать xUnitFor1C](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F-%D0%B4%D0%BB%D1%8F-%D0%BA%D0%BE%D0%BD%D1%82%D1%80%D0%B8%D0%B1%D1%8C%D1%8E%D1%82%D0%BE%D1%80%D0%BE%D0%B2,-%D1%82.%D0%B5.-%D0%B4%D0%BB%D1%8F-%D1%82%D0%B5%D1%85,-%D0%BA%D1%82%D0%BE-%D0%B6%D0%B0%D0%B6%D0%B4%D0%B5%D1%82-%D0%B4%D0%BE%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%B0%D1%82%D1%8C-xUnitFor1C)**

## Что к чему

* *xddTestRunner.epf* - браузер и исполнитель тестов для обычного приложения и управляемого приложения 1С:Предприятия 8 (толстый и тонкий клиенты)
* *xddDataFixtureGen.epf* - генерация макета данных для использования в тестах. Макет можно генерить из боевой базы на основе реальных данных.
* *xddTestRunner.js* - скрипт для Снегопата, позволяющий выполнять тесты прямо из конфигуратора
* *Tests/* - каталог с примерами тестов и с тестами для самотестирования xddTestRunner.epf (подпапка selftests)
* *Tests\CommonApp\тесты_ОткрытиеФормКонфигурации.epf* - тесты открытия всех форм справочников, документов, отчетов и обработок. Для справочников и документов в транзакции создаются новые или копируются или перезаписываются существующие элементы.
* *Tests\CommonApp\Тест_ЗапускТестовВСеансеДругихПользователей.epf* - примеры запуска тестов для пользователей с ограниченными правами. Пользователи создаются на лету из простых макетов.
* *Tests\CommonApp\Тест_ПроверитьОтчетНаСоответствиеЭталону.epf* - пример теста отчета путем сравнения с эталонным ожиданием из макета.

## Как помочь проекту

Мы рады любой помощи: 

1. Если вы занимаетесь разработкой на 1С:Предприятии 8 пробуйте писать и выполнять тесты при помощи xUnitFor1C, сообщайте нам об обнаруженных ошибках, пишите пожелания. Для управления сообщениями об ошибках и пожеланиями мы используем [баг-трекер GitHub'а](https://github.com/xDrivenDevelopment/xUnitFor1C/issues?sort=created&state=open).

2. Если у вас есть время разобраться в исходном коде, вы можете взять на себя реализацию одной из  [открытых задач](https://github.com/xDrivenDevelopment/xUnitFor1C/issues?sort=created&state=open).

3. Если вы уже используете xUnitFor1C на практике, напишите об этом статью, например, на [Инфостарте](http://infostart.ru).

[Инструкция для контрибьюторов, т.е. для тех, кто жаждет доработать xUnitFor1C](https://github.com/xDrivenDevelopment/xUnitFor1C/wiki/%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F-%D0%B4%D0%BB%D1%8F-%D0%BA%D0%BE%D0%BD%D1%82%D1%80%D0%B8%D0%B1%D1%8C%D1%8E%D1%82%D0%BE%D1%80%D0%BE%D0%B2,-%D1%82.%D0%B5.-%D0%B4%D0%BB%D1%8F-%D1%82%D0%B5%D1%85,-%D0%BA%D1%82%D0%BE-%D0%B6%D0%B0%D0%B6%D0%B4%D0%B5%D1%82-%D0%B4%D0%BE%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%B0%D1%82%D1%8C-xUnitFor1C)
