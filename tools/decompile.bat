@echo off
chcp 65001 >nul
rem SET mypath=%~dp0
SET projectdir=%~dp0..

pushd %projectdir%

if not exist ./vanessa-runner (
    git clone https://github.com/silverbulleters/vanessa-runner.git ./vanessa-runner
) 
SET mypath=./vanessa-runner
echo %mypath%

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
rem script %mypath%/runner.os decompileepf %BUILDPATH%\out\ %BUILDPATH%\.. %connstring% 

echo Получение исходников конфигурации
rem oscript %mypath%/runner.os decompilecurrent %config-sources% %connstring% 
