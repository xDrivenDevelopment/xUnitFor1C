@echo off
rem 
rem Тестирование переключения веток хранилища xUnitFor1C
rem
rem Требования: 
rem 	1. Установленный Git. Путь к нему находиться в системном PATH.
rem		2. Доступ к сайту GitHub - https://github.com/xDrivenDevelopment/xUnitFor1C
rem 
rem Пример вызова (переключения master <-> develop и обратно): 
rem 	git_xUnitFor1C_check.cmd
rem или (переключения master <-> develop <-> ИмяДопВетки и обратно): 
rem 	git_xUnitFor1C_check.cmd ИмяДопВетки
rem

setlocal
if "%1"=="" ( set branch=develop 
) else ( 
	set branch=%1
)
	rem echo %branch%

set remoteRepo=https://github.com/xDrivenDevelopment/xUnitFor1C.git
	rem set remoteRepo=C:\Projects\xUnitFor1C_t1\.git

set repo=%CD%\xUnitFor1C_temp831

	rem echo %repo%

rd /S /Q %repo%
if EXIST %repo% (
	tskill TGitCache
	rd /S /Q %repo%
	if EXIST %repo% (
		echo Не удалось удалить каталог %repo%
		exit 1
		pause
	)
)

md %repo%

git -c diff.mnemonicprefix=false -c core.quotepath=false clone --recursive %remoteRepo% %repo%

cd %repo%
git checkout -b develop
if errorlevel 1 (
	echo Не удалось переключиться на ветку develop
	exit 2
	pause
)
git status

if not %branch%==develop (
	git checkout -b %branch%
	if errorlevel 1 (
		echo Не удалось переключиться на ветку %branch%
		exit 5
		pause
	)
	git status
)

git checkout master
if errorlevel 1 (
	echo Не удалось переключиться на ветку master
	exit 3
	pause
)
git status

git checkout  develop
if errorlevel 1 (
	echo Не удалось повторно переключиться на ветку develop
	exit 4 
	pause
)
git status

if not %branch%==develop (
	git checkout %branch%
	if errorlevel 1 (
		echo Не удалось повторно переключиться на ветку %branch%
		exit 6
		pause
	)
	git status
)

git checkout master
if errorlevel 1 (
	echo Не удалось повторно переключиться на ветку master
	exit 7
	pause
)
git status

endlocal
echo Все переключения завершились успешно
exit 0