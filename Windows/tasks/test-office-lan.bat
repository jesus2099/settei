@echo off
setlocal EnableDelayedExpansion

del "%~dp0_vpn-flag" 2>nul
del "%~dp0_reachable-flag" 2>nul

(
	echo.
	echo #######################################################################
	echo %~nx0 version %~t0
	echo.
	date /t
	time /t
) >>"%~dpn0.log"

echo Starting Caffeine off...
start "Caffeine" "%LocalAppData%\Programs\_\caffeine64.exe" -stes -onac -notwhenlocked -startoff -replace

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

echo ### !_location! ###
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

echo ### !_location! ###
goto !_location!

:office

set _need_office_apps=1
date /t >"%~dp0_reachable-flag"
goto online

:home

echo Starting Caffeine on ^(keep PC awake^)...
start "Caffeine" "%LocalAppData%\Programs\_\caffeine64.exe" -stes -onac -notwhenlocked -replace

:online


if !_location! equ office (
	set _need_office_apps=1
) else (
	set _conn_choice_default=y
	set _conn_choice_time=10
	set "_conn_choice_text=[Yes] / No / Connected"
	for /f %%c in ('powershell -noprofile -command "[System.Console]::CapsLock"') do set "_capslock=%%c"
	for /f %%n in ('powershell -noprofile -command "[System.Console]::NumberLock"') do set "_numlock=%%n"
	if /i !_capslock! == True (
	    echo Caps Lock is ON: Default on not reachable
	    set _conn_choice_default=c
	    set "_conn_choice_text=Yes / No / [Connected]"
		if /i !_numlock! == True (
		    echo Num Lock is ON: Speed up connection
		    set _conn_choice_time=2
		)
	)
	echo.
	echo   °°    °° °°°°°°  °°°    °°     °°°°°°  
	echo   ±±    ±± ±±   ±± ±±±±   ±±          ±± 
	echo   ±±    ±± ±±±±±±  ±± ±±  ±±       Ü±±±  
	echo    ²²  ²²  ²²      ²²  ²² ²²       ßß    
	echo     ÛÛÛÛ   ÛÛ      ÛÛ   ÛÛÛÛ       ÛÛ    
	echo.
	choice /c ync /n /d !_conn_choice_default! /t !_conn_choice_time! /m "!_conn_choice_text! but not reachable"
	set _vpn=!errorlevel!

	if !_vpn! neq 2 (

		if !_vpn! equ 1 (
			date /t >"%~dp0_reachable-flag"
		)

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
			for /f "tokens=1 delims=," %%a in ('tasklist /fo csv /nh /fi "WindowTitle eq PingID"') do (
				if "%%~a" == "PingID.exe" (
					set _pingid_found=1
					echo.
					echo PingID always on top...
					rem nircmd cmdwait 1000 win settopmost process PingID.exe 1
					rem nircmd cmdwait 500 win trans process PingID.exe 200
					rem nircmd cmdwait 500 win flash process PingID.exe 5
					rem nircmd cmdwait 500 win activate process PingID.exe
					rem nircmd cmdwait 1000 sendkey 0x09 press
					rem nircmd cmdwait 200 sendkey 0x09 press
					nircmd win settopmost process PingID.exe 1
					nircmd win trans process PingID.exe 200
					nircmd win flash process PingID.exe 5
					nircmd win activate process PingID.exe
					nircmd sendkey 0x09 press
					nircmd sendkey 0x09 press
					goto stop_wait_for_pingid
				) else (
					timeout /t 1 >nul
					goto wait_for_pingid
				)
			)
			if !_pingid_found neq 1 goto wait_for_pingid
			:stop_wait_for_pingid
			rem no empty line after label
		)

		where wevtutil >nul 2>nul && where timeout >nul 2>nul && where powershell >nul 2>nul
		if !errorlevel! equ 0 (
			set _vpn_wait_time_min=30
			set _vpn_wait_check_delay_s=2
			set /a "_vpn_wait_time_s= _vpn_wait_time_min * 60"
			set /a "_vpn_max_retry= _vpn_wait_time_s / _vpn_wait_check_delay_s"
			for /f "delims=" %%T in ('powershell get-date -format "yyyy-MM-ddTHH:mm:ssZ" ^(get-date^).toUniversalTime^(^)') do set _wait_start_ts=%%T
			set /p "=Waiting for VPN ^(!_vpn_wait_time_min! min max^).." <nul
			:wait_for_vpn
			set /a "_vpn_max_retry-=1"
			set /p "=." <nul
			if !_vpn_max_retry! leq 0 (
				echo.
				goto stop_wait_for_vpn
			)
			wevtutil qe /rd:true /f:text /q:"Event[System[Provider[@Name='IVE']][EventID=312][TimeCreated[@SystemTime ^>= '!_wait_start_ts!']]]" "Pulse Secure/Operational"|find "was established successfully to https://"
			if !errorlevel! equ 0 (
				set _need_office_apps=1
				goto stop_wait_for_vpn
			) else (
				timeout /t !_vpn_wait_check_delay_s! >nul
				goto wait_for_vpn
			)
			:stop_wait_for_vpn
			rem no empty line after label
		)
	)
)

if !_need_office_apps! equ 1 (
	call "%~dp0\start-office-apps.bat"
)

goto end

:offline

:end

echo Location: !_location!
echo Location: !_location! >>"%~dpn0.log"
echo errorlevels ^(home, office, github.com, gmail.com, ymail.com^): !_home!.!_office!.!_github!.!_gmail!.!_ymail! >>"%~dpn0.log"

set _power=battery
for /f "skip=1" %%a in ('wmic Path Win32_Battery Get BatteryStatus') do for %%b in (2 6 7 8) do if %%a == %%b set _power=connected
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
echo Power: !_power!

timeout /t 20
