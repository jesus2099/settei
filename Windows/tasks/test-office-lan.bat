@echo off
setlocal enableDelayedExpansion

del "%~dp0_vpn-flag"
del "%~dp0_reachable-flag"

(
	echo.
	echo #######################################################################
	echo %~nx0 version %~t0
	echo.
	date /t
	time /t
) >>"%~dpn0.log"

mode con cp select=850 >nul 2>>"%~dpn0.log"

rem -----------------------------------------------------------------------
rem CR LF
rem https://ss64.com/nt/findstr.html
rem https://ss64.com/nt/findstr-linebreaks.html Searching across Line Breaks: CR and LF characters must be matched explictly
rem https://ss64.com/nt/findstr-escapes.html Search String length limits: 511 bytes for text / 254 bytes for regular expressions (actually 278 bytes on my PC)
rem Define LF variable containing a linefeed (0x0A)
set LF=^


rem Above 2 blank lines are critical
rem Define CR variable containing a carriage return (0x0D)
for /f %%a in ('copy /z "%~dpf0" nul') do set "CR=%%a"
rem -----------------------------------------------------------------------

rem ipconfig|findstr gives random results
ipconfig >"%~dp0_ipconfig"
findstr /rc:"!CR!*!LF!!CR!*!LF!   Suffixe DNS propre … la connexion.*: numericable\.fr!CR!*!LF!   Adresse IPv6 de liaison locale.*: fe80::.*!CR!*!LF!   Adresse IPv4.*: 192\.168\.0\..*!CR!*!LF!   Masque de sous-r‚seau.*: 255\.255\.255\.0!CR!*!LF!   Passerelle par d‚faut.*: 192\.168\.0\.1$" "%~dp0_ipconfig" >>"%~dpn0.log"
set _home=!errorlevel!
del "%~dp0_ipconfig"

for /f "tokens=11 delims= " %%a in ('ipconfig ^| findstr /nrc:"Suffixe DNS propre … la connexion[. ]*: fr.*\.ad\.[fiancer]*\.fr$"') do set _dns=%%a

if defined _dns (
	ping -n 2 !_dns:~7!
	set _office=!errorlevel!
) else (
	set _office=1
)

set _location=other
if !_home!!_office! == 01 set _location=home
if !_home!!_office! == 10 set _location=office

if !_location! equ office (
	rem https://texteditor.com/multiline-text-art/
	echo.
	echo    _______                             __                __       __                ____  
	echo   ^|       \                           ^|  \              ^|  \     ^|  \              /    \ 
	echo   ^| ²²²²²²²\ ______   ______   _______^| ²²____   ______ ^| ²²____ ^| ²² ______      ^|  ²²²²\
	echo   ^| ²²__^| ²²/      \ ^|      \ /       \ ²²    \ ^|      \^| ²²    \^| ²²/      \      \²²^| ²²
	echo   ^| ²²    ²²  ²²²²²²\ \²²²²²²\  ²²²²²²² ²²²²²²²\ \²²²²²²\ ²²²²²²²\ ²²  ²²²²²²\       /  ²²
	echo   ^| ²²²²²²²\ ²²    ²²/      ²² ²²     ^| ²²  ^| ²²/      ²² ²²  ^| ²² ²² ²²    ²²      ^|  ²² 
	echo   ^| ²²  ^| ²² ²²²²²²²²  ²²²²²²² ²²_____^| ²²  ^| ²²  ²²²²²²² ²²__/ ²² ²² ²²²²²²²²       \²²  
	echo   ^| ²²  ^| ²²\²²     \\²²    ²²\²²     \ ²²  ^| ²²\²²    ²² ²²    ²² ²²\²²     \      ^|  \  
	echo    \²²   \²² \²²²²²²² \²²²²²²² \²²²²²²²\²²   \²² \²²²²²²²\²²²²²²² \²² \²²²²²²²       \²²  
	echo.
	choice /c yn /n /d y /t 10 /m "[Yes] / No"
	set _vpn=!errorlevel!
) else (
	echo.
	echo   °°    °° °°°°°°  °°°    °°     °°°°°°  
	echo   ±±    ±± ±±   ±± ±±±±   ±±          ±± 
	echo   ±±    ±± ±±±±±±  ±± ±±  ±±       Ü±±±  
	echo    ²²  ²²  ²²      ²²  ²² ²²       ßß    
	echo     ÛÛÛÛ   ÛÛ      ÛÛ   ÛÛÛÛ       ÛÛ    
	echo.
	choice /c ync /n /d y /t 10 /m "[Yes] / No / Connected but not reachable"
	set _vpn=!errorlevel!
)

if !_vpn! equ 1 date /t >"%~dp0_reachable-flag"

goto !_location!

:other

ping -n 2 github.com
set _github=!errorlevel!

ping -n 2 gmail.com
set _gmail=!errorlevel!

ping -n 2 ymail.com
set _ymail=!errorlevel!

set _location=offline
if not !_github!!_gmail!!_ymail! == 111 set _location=online

echo goto !_location!
goto !_location!

:office

echo Starting Caffeine off...
start "Caffeine" "%LocalAppData%\Programs\_\caffeine64.exe" -stes -onac -notwhenlocked -startoff -replace

call "%~dp0\start-office-apps.bat"
goto end

:home

echo Starting Caffeine on ^(keep PC awake^)...
start "Caffeine" "%LocalAppData%\Programs\_\caffeine64.exe" -stes -onac -notwhenlocked -replace

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

:online

if !_vpn! neq 2 (
	echo Starting PingID...
	start "PingID" "%ProgramFiles(x86)%\Ping Identity\PingID\PingID.exe"
	echo Starting Pulse Secure...
	start "Pulse Secure" "%ProgramFiles(x86)%\Common Files\Pulse Secure\JamUI\Pulse.exe" -show
	where nircmd >nul 2>nul && where timeout >nul 2>nul
	if !errorlevel! equ 0 (
		set /p "=Waiting for PingID.." <nul
		set _pingid_max_retry=60
		:wait_for_pingid
		set /a "_pingid_max_retry-=1"
		set /p "=." <nul
		if !_pingid_max_retry! leq 0 (
			echo.
			goto stop_wait_for_pingid
		)
		for /f "tokens=8,9 delims=," %%a in ('tasklist /v /fo csv /nh /fi "imagename eq PingID.exe"') do (
			if "%%~b" == "PingID" (
				set _pingid_found=1
				set _pingid_cpu_time=%%~a
				set _pingid_cpu_time=!_pingid_cpu_time::=!
				if !_pingid_cpu_time! geq 5 (
					echo.
					echo PingID always on top...
					timeout /t 1 >nul
					nircmd win settopmost process PingID.exe 1
					nircmd win trans process PingID.exe 200
					nircmd win flash process PingID.exe 5
					nircmd win activate process PingID.exe
					nircmd sendkey 0x09 press
					nircmd sendkey 0x09 press
					goto stop_wait_for_pingid
				)
			) else (
				timeout /t 1 >nul
				goto wait_for_pingid
			)
		)
		if !_pingid_found neq 1 goto wait_for_pingid
		:stop_wait_for_pingid
		rem echo prout
	)
)
echo goto end
goto end

:offline

:end

echo location: !_location!
echo location: !_location! >>"%~dpn0.log"
echo errorlevels ^(home, office, github.com, gmail.com, ymail.com^): !_home!.!_office!.!_github!.!_gmail!.!_ymail! >>"%~dpn0.log"

timeout /t 10
