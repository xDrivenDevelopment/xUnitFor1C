echo off

rem SET mypath=%~dp0
rem SETLOCAL

SET projectdir=%~dp0..

SET mypath=C:\projects\vanessa-runner\tools

set BUILDPATH=%projectdir%\build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

rem set RUNNER_IBNAME=/F"D:\work\base\dev"
rem set RUNNER_DBUSER=base
rem set RUNNER_DBPWD=234567890

rem 
SET RUNNER_ENV=production

SET connstring=--ibname /F"%BUILDPATH%\ib"

echo "watch"
rem oscript -encoding=utf-8 %mypath%/runner.os watch %projectdir%/compile.json
oscript %mypath%/runner.os watch %projectdir%/compile.json
exit /B
