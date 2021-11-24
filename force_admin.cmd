@echo off

:CheckUAC
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' goto Execute

:ForceUAC
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\admin_reexecute.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\execute_as_admin.vbs"
"%temp%\execute_as_admin.vbs"
del "%temp%\execute_as_admin.vbs"
exit /b

:Execute
@REM add your real scripts that should be executed as admin privilege
