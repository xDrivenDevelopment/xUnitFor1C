echo off
rem SET mypath=%~dp0
SET projectdir=%~dp0..

SET mypath=C:\projects\vanessa-runner\tools
echo %mypath%
SETLOCAL

set BUILDPATH=%projectdir%\build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

rem set RUNNER_IBNAME=/F"%BUILDPATH%\ib"
rem set RUNNER_DBUSER=base
rem set RUNNER_DBPWD=234567890
SET USERPWD=--db-user admin

rem 
SET RUNNER_ENV=production

SET connstring=--ibname /F"%BUILDPATH%\ib" %USERPWD%

echo "compileepf"
rem oscript -encoding=utf-8 %mypath%/runner.os compileepf .\ %BUILDPATH%\out\
oscript %mypath%/runner.os compileepf %BUILDPATH%\.. %BUILDPATH%\out\ %connstring% 
exit /B
