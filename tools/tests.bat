chcp 1251
rem SET mypath=%~dp0
SET projectdir=%~dp0..

SET mypath=C:\projects\vanessa-runner\tools
echo %mypath%

rem SET USERPWD=--db-user base --db-pwd 234567890
SET USERPWD=--db-user admin

set BUILDPATH=%projectdir%\build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

rem set RUNNER_IBNAME=/F"%BUILDPATH%\ib"
SET connstring=--ibname /F"%BUILDPATH%\ib"

echo "run tests"
oscript %mypath%/runner.os xunit %projectdir%\tests\utils --reportxunit "./build/report.xml" %connstring% %USERPWD% --pathxunit %projectdir%\xddTestRunner.epf 

