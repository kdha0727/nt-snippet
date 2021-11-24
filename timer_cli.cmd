@echo off
@REM CLI Timer - based on ping
@REM Created on 2019. 02. 01.
title Timer
pushd %~dp0

SET ScriptPath=%~dp0
IF EXIST %Windir%\System32\sppsvc.exe  set SysPath=%Windir%\System32
IF EXIST %Windir%\Sysnative\sppsvc.exe set SysPath=%Windir%\Sysnative

:admincheck
echo.
echo. This program can be launched by admin mode.
ping -n 2 localhost>nul
echo Admin_test > %SysPath%\admin_test.txt
if not exist %SysPath%\admin_test.txt goto:not_admin
del /s /q %SysPath%\admin_test.txt > nul
set admintoggle=Timer (ADMIN MODE) 

:home
cls
echo Copyright (C) Dongha Kim. All rights reserved.
echo ===========================================================
echo.
echo.
echo  %admintoggle% 
echo  Enter HOUR
echo.
set h=0
set /p h= ENTER TIME : 
cls
echo Copyright (C) Dongha Kim. All rights reserved.
echo ===========================================================
echo.
echo.
echo  %admintoggle%
echo  Enter MIN (less than 60)
echo.
set m=0
set /p m= ENTER TIME : 
cls
echo Copyright (C) Dongha Kim. All rights reserved.
echo ===========================================================
echo.
echo.
echo  %admintoggle%
echo  Enter SECOND (less than 60)
echo.
set s=0
set /p s= ENTER TIME : 
cls
echo Copyright (C) Dongha Kim. All rights reserved.
echo ===========================================================
echo.
echo.
echo  %admintoggle%
echo  Enter TIMEOUT OPTION
echo  Shutdown-s Reboot-r Logoff-l HybridSleep-h
echo.
set w=n
set /p w= ENTER OPTION : 
if /i %w%==n goto start
if /i %w%==s goto start
if /i %w%==r goto start
if /i %w%==l goto start
if /i %w%==h goto start
set w=n& goto start

:start
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo                                        Start!
echo.
echo.
ping 127.0.0.1 -n 2 >nul

:timer
cls
echo.
echo.
echo.                                         %h%
echo                                        Hour(s)
echo.                                         %m%
echo                                       Minute(s)
echo.                                         %s%
echo                                       Second(s)
echo.
set /A s=s-1
if /i %s% == -1 set /a m=m-1 & set /a s=s+60
if /i %m% == -1 set /a h=h-1 & set /a m=m+60
if /i %h% == -1 goto timeout
ping 127.0.0.1 -n 2 >nul
goto:timer

:timeout
if /i %w%==s shutdown -s -f -t 5
if /i %w%==r shutdown -r -f -t 5
if /i %w%==l shutdown -l
if /i %w%==h shutdown -h
:timeoutloop
cls
echo.
echo.
echo.
echo.
echo.
echo                                      0 Second!
echo                                   1. exit 2. main
echo.
echo.
set /p o= ENTER OPTIONS : 
if %o%==1 exit
if %o%==2 goto home
goto timeoutloop

:not_admin
cls
echo Copyright (C) Dongha Kim. All rights reserved.
echo ===========================================================
echo.
echo.
echo. Run as administrator to use all utilities
echo.
pause >nul
set admintoggle=Timer
goto home
