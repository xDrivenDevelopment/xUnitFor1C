@echo off
rem SET mypath=%~dp0
SET projectdir=%~dp0..

SET mypath=C:\projects\vanessa-runner\tools
echo %mypath%

rem SET USERPWD=--db-user base --db-pwd 234567890
rem SET connstring=
SET USERPWD=--db-user admin
rem 
SET RUNNER_ENV=production

set BUILDPATH=%projectdir%\build
rem if not exist %BUILDPATH% set BUILDPATH=..\build

SET connstring=--ibname /F"%BUILDPATH%\ib" %USERPWD%

@rem oscript -encoding=utf-8 %mypath%/runner.os decompileepf %BUILDPATH%\out\ %BUILDPATH%\..\src %connstring% 
oscript %mypath%/runner.os decompileepf %BUILDPATH%\out\ %BUILDPATH%\.. %connstring% 
