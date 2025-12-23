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

call "%~dp0\start-office-apps.bat"
goto online

:home

echo Starting Caffeine on ^(keep PC awake^)...
start "Caffeine" "%LocalAppData%\Programs\_\caffeine64.exe" -stes -onac -notwhenlocked -replace

:online

if !_location! equ office (
	set _vpn=1
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

	if !_vpn! neq 2 (

		if !_vpn! equ 1 (
			date /t >"%~dp0_reachable-flag"
			query process | find /i "ms-teams.exe" >nul
			if !errorlevel! equ 1 (
				echo Starting Teams...
				rem find app ID by exploring shell:AppsFolder and create shortcut
				start shell:AppsFolder\MSTeams_8wekyb3d8bbwe^^!MSTeams
			) else (
				echo Teams is running
			)
		)

		echo Starting PingID...
		start "PingID" "%ProgramFiles(x86)%\Ping Identity\PingID\PingID.exe"
		echo Starting Pulse Secure...
		start "Pulse Secure" "%ProgramFiles(x86)%\Common Files\Pulse Secure\JamUI\Pulse.exe" -show
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
				call "%~dp0\start-office-apps.bat"
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
