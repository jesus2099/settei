@echo off
setlocal

del %~dp0_vpn-flag

                      ipconfig|find "Suffixe DNS propre à la connexion. . . : numericable.fr"
if %errorlevel% equ 0 ipconfig|find "Adresse IPv6 de liaison locale. . . . .: fe80::"
if %errorlevel% equ 0 ipconfig|find "Adresse IPv4. . . . . . . . . . . . . .: 192.168.0."
if %errorlevel% equ 0 ipconfig|find "Masque de sous-réseau. . . . . . . . . : 255.255.255.0"
if %errorlevel% equ 0 ipconfig|find "Passerelle par défaut. . . . . . . . . : 192.168.0.1"
set _home=%errorlevel%

ping -n 1 github.com
set _github=%errorlevel%

ping -n 1 ymail.com
set _ymail=%errorlevel%

echo home, ymail.com, github.com: %_home%%_ymail%%_github%

set _location=end

if %_home%%_github%%_ymail% == 000 set _location=home
if %_home%%_github%%_ymail% == 101 set _location=office
if %_home%%_github%%_ymail% == 111 set _location=offline
if %_home%%_github%%_ymail% == 100 set _location=other

(
	echo ----------
	echo.
	date /t
	time /t
	echo %_location%
	echo.
) >>%~dpn0.log

echo %_location%
goto %_location%

:office

call %~dp0\start-office-apps.bat
goto end

:home

query process|find /i "move mouse.exe">NUL
if %errorlevel% equ 1 (echo Starting Move Mouse ^(anti lock^) & start "Move Mouse" shell:appsfolder\1258EllAbi.MoveMouse_hjfwaxvfbwh7t!MyDesktopAppStep1)

:other

start "PingID" "%ProgramFiles% (x86)\Ping Identity\PingID\PingID.exe"
goto end

:offline

:end
