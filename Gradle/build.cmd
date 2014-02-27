@echo off
chcp 1251 >nul
REM 
@gradle --info -q xUnitFor1C_82 xUnitFor1C_82_Managed
REM gradle --info -Dfile.encoding=utf-8 -q xUnitFor1C
rem @pause