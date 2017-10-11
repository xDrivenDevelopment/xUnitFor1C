@rem Полная инициализация из репозитария и начальное заполнение ИБ ./build/ibservice
@rem Пример запуска 83test.cmd

@chcp 65001

@set RUNNER_IBCONNECTION=/F./build/ibservice

@call runner init-dev --src src/tests/cf/83

@IF ERRORLEVEL 1 goto error

@REM @call runner run --command "ЗапуститьОбновлениеИнформационнойБазы;ЗавершитьРаботуСистемы;" --execute $runnerRoot\epf\ЗакрытьПредприятие.epf

@REM @IF ERRORLEVEL 1 goto error

@call runner run --command СоздатьАдминистратора

@IF ERRORLEVEL 1 goto error

@echo .
@echo Дымовое тестирование
@echo .
@call runner xunit --settings tools/vrunner.json

@call allure generate ./build/out/allure

@call allure report open

@goto end

:error

@echo ОШИБКА!

@goto end

:end
