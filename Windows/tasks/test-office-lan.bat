@echo off
setlocal

set _officeOrHome=home

ipconfig|grep 192.168.0.
if errorlevel 1 set _officeOrHome=office

(
	echo ----------
	echo.
	date /t
	time /t
	echo %_officeOrHome%
	echo.
) >>$0.log

goto %_officeOrHome%

:office

call start-office-apps.bat
goto end

:home

query process|find /i "move mouse.exe">NUL
if %errorlevel% equ 1 (echo Starting Move Mouse ^(anti lock^) & start "Move Mouse" shell:appsfolder\1258EllAbi.MoveMouse_hjfwaxvfbwh7t!MyDesktopAppStep1)

start "PingID" "%ProgramFiles% (x86)\Ping Identity\PingID\PingID.exe"
goto end

:end
