@echo off
if not "%1"=="" call :%1 %* & exit /b

:help
echo RE - Resource Embedder.
echo.
echo Usage Example:
echo re e "Resource1.png" "OutputFile.bat"
echo.
echo The above example will encode, and then embed the
echo file "Resource1.png" and then place a copy in Base64
echo inside of "OutputFile.bat". Optionally, you can specify
echo "con" as an output file to output to console.
echo.
echo Warning:
echo With the current version of RE, you can only embed one resource into a file.
echo This is being worked on and should soon be fixed in the next release, so for
echo now, you should try putting all your files into one ZIP or CAB file.
echo.
echo.
echo Wanna contribute?
echo Head over to https://1f.ddns.net/r/REGithub.
exit /b

:e
if not exist "%2" echo ERR: The specified input file does not exist. & exit /b
set jid=%random%
echo Jump ID: %jid%
echo Encoding file as Base64
certutil -encode "%2" "%2.tmp" >NUL
echo Done encoding. Creating temporary batch file.
>tmp%jid%.bat (
echo goto ^:jmp%jid%
echo :: RE EMBEDDED RESOURCE
echo :: NAME: %2
type "%2.tmp"
echo ^:jmp%jid%
echo certutil -decode %%0 %2
)
echo Done creating temporary batch file.
echo Now writing changes to specified output file.
type tmp%jid%.bat >>%3
echo Complete! Cleaning up temporary files.
del %2.tmp
del tmp%jid%.bat
echo Exiting.
exit /b