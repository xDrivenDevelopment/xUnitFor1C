rem echo off
rem SET mypath=%~dp0
SET projectdir=%~dp0..

SET mypath=C:\projects\vanessa-runner\tools
echo %mypath%
SETLOCAL

set BUILDPATH=%projectdir%\build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

rem set RUNNER_IBNAME=/F"D:\work\base\dev"
rem set RUNNER_DBUSER=base
rem set RUNNER_DBPWD=234567890

SET RUNNER_ENV=production

SET connstring=--ibname /F"%BUILDPATH%\ib"

IF "%~1"=="" (
set mode="%projectdir%/Tests\cf\83"
) else (
set mode=%1
)

echo "init"
rem oscript -encoding=utf-8 %mypath%/init.os init-dev --src %mode%
rem oscript -encoding=utf-8 %mypath%/init.os init-dev --src %mode% --dev

oscript %mypath%/init.os init-dev --src %mode%
oscript %mypath%/init.os init-dev --src %mode% --dev

echo "create admin user"
oscript %mypath%/runner.os xunit %projectdir%\tests\init --reportxunit "./build/init-report.xml" %connstring% --pathxunit %projectdir%\xddTestRunner.epf 


exit /B
