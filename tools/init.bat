@rem в качестве первого параметра может принимать путь к каталогу с исходниками конфигурации. 
@rem Если параметр не передан, используется путь по умолчанию - Tests\cf\83

@echo off
SET projectdir=%~dp0..

SET runner-dir=C:\projects\vanessa-runner\tools
echo %runner-dir%
SETLOCAL

pushd %projectdir%

set BUILDPATH=.\build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

rem set RUNNER_IBNAME=/F"D:\work\base\dev"
rem set RUNNER_DBUSER=base
rem set RUNNER_DBPWD=234567890

SET RUNNER_ENV=production

SET connstring=--ibname /F"%BUILDPATH%\ib"

IF "%~1"=="" (
set config-sources="./Tests\cf\83"
) else (
set config-sources=%1
)

echo "init"

oscript %runner-dir%/init.os init-dev --src %config-sources%
oscript %runner-dir%/init.os init-dev --src %config-sources% --dev

echo "create admin user - ib"
oscript %runner-dir%/runner.os run --command AdminCreate %connstring% 

exit /B
