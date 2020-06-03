@echo off

:: Note:
:: This file is for testing processing multiple files at once, by using a CAB archive.
:: At the moment, it doesn't work, and I've made it external for ease of testing.

set files=%1
set outfile=%2
set tmpid=%random%
>%tmpid%.ddf (
	echo .OPTION EXPLICIT
	echo .Set CabinetNameTemplate=s%tmpid%_*.cab
	echo .Set Cabinet=on
	echo .Set Compress=on
)

for %%a in ("%files::=" "%") do (
	echo %%a >>%tmpid%.ddf
)
type %tmpid%.ddf
makecab /F %tmpid%.ddf
re e s%tmpid%.cab %2
del s%tmpid%.cab
del %tmpid%.ddf
