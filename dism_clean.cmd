@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    goto UACAccess
) else ( goto Done )

:UACAccess
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\uac_get_admin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\uac_get_admin.vbs"
"%temp%\uac_get_admin.vbs"
del "%temp%\uac_get_admin.vbs"
exit /b

:Done
echo Analyzing...
dism /online /cleanup-image /analyzecomponentstore
echo.
echo Cleaning...
dism /online /cleanup-image /startcomponentcleanup
echo.
echo Re-analyzing...
dism /online /cleanup-image /analyzecomponentstore
echo.
echo All done.
echo Press any key to exit... 
pause>nul
