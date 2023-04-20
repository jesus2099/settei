@echo off
setlocal enableDelayedExpansion

del %~dp0_vpn-flag

(
	echo.
	echo ----------
	echo %~nx0 version %~t0
	echo.
	date /t
	time /t
) >> %~dpn0.log

rem -----------------------------------------------------------------------
rem https://ss64.com/nt/findstr.html
rem https://ss64.com/nt/findstr-linebreaks.html Searching across Line Breaks: CR and LF characters must be matched explictly
rem https://ss64.com/nt/findstr-escapes.html Search String length limits: 511 bytes for text / 254 bytes for regular expressions (actually 278 bytes on my PC)
rem Define LF variable containing a linefeed (0x0A)
set LF=^


rem Above 2 blank lines are critical
rem Define CR variable containing a carriage return (0x0D)
for /f %%a in ('copy /z "%~dpf0" nul') do set "CR=%%a"
rem -----------------------------------------------------------------------

rem Code Page 850
ipconfig | findstr /rc:"^   Suffixe DNS propre … la connexion.*: numericable\.fr!CR!*!LF!   Adresse IPv6 de liaison locale.*: fe80::.*!CR!*!LF!   Adresse IPv4.*: 192\.168\.0\..*!CR!*!LF!   Masque de sous-r‚seau.*: 255\.255\.255\.0!CR!*!LF!   Passerelle par d‚faut.*: 192\.168\.0\.1$" >> %~dpn0.log
set _home=%errorlevel%

rem Code Page 850
for /f "tokens=11 delims= " %%a in ('ipconfig ^| findstr /nrc:"Suffixe DNS propre … la connexion[. ]*: fr.*\.ad\.[fiancer]*\.fr$"') do set _dns=%%a

if defined _dns (
	ping %_dns%
	set _office=!errorlevel!
)

set _location=other
if %_home%%_office% == 01 set _location=home
if %_home%%_office% == 10 set _location=office

goto %_location%

:other

ping github.com
set _github=%errorlevel%

ping gmail.com
set _gmail=%errorlevel%

ping ymail.com
set _ymail=%errorlevel%

set _location=offline
if not %_github%%_gmail%%_ymail% == 111 set _location=online

goto %_location%

:office

call %~dp0\start-office-apps.bat
goto end

:home

for /f "skip=1" %%a in ('wmic Path Win32_Battery Get BatteryStatus') do for %%b in (2 6 7 8) do if %%a == %%b goto power

rem my laptop only knows statuses 1 for battery and 2 for power cord
rem https://learn.microsoft.com/windows/win32/cimwin32prov/win32-battery
rem Other (1) The battery is discharging.
rem Unknown (2) The system has access to AC so no battery is being discharged. However, the battery is not necessarily charging.
rem Fully Charged (3)
rem Low (4)
rem Critical (5)
rem Charging (6)
rem Charging and High (7)
rem Charging and Low (8)
rem Charging and Critical (9)
rem Undefined (10)
rem Partially Charged (11)

:battery

echo On battery

goto online

:power

echo Power connected
query process|find /i "move mouse.exe">NUL
if %errorlevel% equ 1 (echo Starting Move Mouse ^(anti lock^) & start "Move Mouse" "%UserProfile%\Documents\PRG\Move Mouse.exe")

:online

start "PingID" "%ProgramFiles% (x86)\Ping Identity\PingID\PingID.exe"
goto end

:offline

:end

echo location: %_location% >> %~dpn0.log
echo errorlevels ^(home, office, github.com, gmail.com, ymail.com^): %_home%.%_office%.%_github%.%_gmail%.%_ymail% >> %~dpn0.log
