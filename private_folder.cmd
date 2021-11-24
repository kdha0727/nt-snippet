@ECHO OFF

PUSHD "%~dp0"

if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK

if NOT EXIST Private goto MAKEDIR

:LOCK

ren Private "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

echo Folder Locked successfully

echo.

pause

exit

:UNLOCK

set /p pass=">"

if NOT "%pass%"=="password" exit

cls

attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" Private

echo.

echo Folder Unlocked successfully

echo.

pause

exit

:MAKEDIR

md Private

echo.

echo Private created successfully

echo.

pause

exit
