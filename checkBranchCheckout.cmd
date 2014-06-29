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

set git_cmd=git
if EXIST "%LOCALAPPDATA%\Atlassian\SourceTree\git_local\cmd\git.exe" set git_cmd="%LOCALAPPDATA%\Atlassian\SourceTree\git_local\cmd\git.exe"

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

%git_cmd% -c diff.mnemonicprefix=false -c core.quotepath=false clone --recursive %remoteRepo% %repo%

set old_branch=master
cd %repo%
%git_cmd% checkout -b develop origin/develop
if errorlevel 1 (
	echo .
	echo Не удалось переключиться на ветку develop из ветки %old_branch%
	pause
	exit 2
)
%git_cmd% status
set old_branch=develop

if not %branch%==develop (
	%git_cmd% checkout -b %branch% origin/%branch%
	if errorlevel 1 (
		echo .
		echo Не удалось переключиться на ветку %branch% из ветки %old_branch%
		pause
		exit 5
	)
	%git_cmd% status
	set old_branch=%branch%
)

%git_cmd% checkout master
if errorlevel 1 (
	echo .
	echo Не удалось переключиться на ветку master из ветки %old_branch%
	pause
	exit 3
)
%git_cmd% status
set old_branch=master

%git_cmd% checkout  develop
if errorlevel 1 (
	echo .
	echo Не удалось повторно переключиться на ветку develop из ветки %old_branch%
	pause
	exit 4 
)
%git_cmd% status
set old_branch=develop

if not %branch%==develop (
	%git_cmd% checkout %branch%
	if errorlevel 1 (
		echo .
		echo Не удалось повторно переключиться на ветку %branch% из ветки %old_branch%
		pause
		exit 6
	)
	%git_cmd% status
	set old_branch=%branch%
)

%git_cmd% checkout master
if errorlevel 1 (
	echo .
	echo Не удалось повторно переключиться на ветку master из ветки %old_branch%
	pause
	exit 7
)
%git_cmd% status
set old_branch=master

endlocal
echo Все переключения завершились успешно
exit 0