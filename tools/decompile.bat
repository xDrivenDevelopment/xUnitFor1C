@echo off
chcp 65001 >nul
rem SET mypath=%~dp0
SET projectdir=%~dp0..

SET mypath=C:\projects\vanessa-runner\tools
echo %mypath%

pushd %projectdir%

IF "%~1"=="" (
set config-sources="./Tests\cf\83"
) else (
set config-sources=%1
)

rem SET USERPWD=--db-user base --db-pwd 234567890
rem SET connstring=
SET USERPWD=--db-user admin
rem 
SET RUNNER_ENV=production

set BUILDPATH=./build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

SET connstring=--ibname /F"%BUILDPATH%\ib" %USERPWD%

echo Получение исходников внешних обработок
@rem oscript -encoding=utf-8 %mypath%/runner.os decompileepf %BUILDPATH%\out\ %BUILDPATH%\..\src %connstring% 
oscript %mypath%/runner.os decompileepf %BUILDPATH%\out\ %BUILDPATH%\.. %connstring% 

echo Получение исходников конфигурации
oscript %mypath%/runner.os decompilecurrent %config-sources% %connstring% 
