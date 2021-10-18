@echo off

ipconfig|grep 192.168.0.
if errorlevel 1 goto office
goto home

:office

call start-office-apps.bat
goto end

:home

query process|find /i "move mouse.exe">NUL
if %errorlevel% equ 1 (echo Starting Move Mouse ^(anti lock^) & start "Move Mouse" shell:appsfolder\1258EllAbi.MoveMouse_hjfwaxvfbwh7t!MyDesktopAppStep1)

start "PingID" "%ProgramFiles% (x86)\Ping Identity\PingID\PingID.exe"
goto end

:end
