@echo off

rem chcp 866
xcopy /Y /J .\82\mygradle.properties .\
dir .\mygradle.properties

chcp 1251 >nul

REM 
@gradle -q xUnitFor1C
REM gradle --info -Dfile.encoding=utf-8 -q xUnitFor1C
rem @pause