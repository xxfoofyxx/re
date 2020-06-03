@echo off
set count=0
set output=
set rnum=
:loop
set /a count=%count% + 1
set /a output=(%random% %% 6)+1
set /p "=%output%" <nul
if %count%==%1 exit /b
goto loop