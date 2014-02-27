@echo off
chcp 1251 >nul
REM 
@gradle --info -q xUnitFor1C
REM gradle --info -Dfile.encoding=utf-8 -q xUnitFor1C
rem @pause