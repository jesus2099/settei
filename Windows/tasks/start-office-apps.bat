@echo off
setlocal EnableDelayedExpansion

if not exist "%~dp0_vpn-flag" (

	query process Emul_Launcher.exe 2>nul | find /i "emul_launche" >nul
	if !errorlevel! equ 1 (
		for /f "delims=" %%E in ('where /f /r "%ProgramFiles(x86)%" Emul_Launcher.exe') do set _emul=%%E
		if defined _emul (
			echo Starting Intranex...
			start "Intranex" !_emul!
		) else (
			echo Intranex not found
		)
	) else (
		echo Intranex is running
	)

	query process | find /i "vivaldi.exe" >nul
	if !errorlevel! equ 1 (
		for %%V in (
			"%LocalAppData%\Vivaldi\Application\vivaldi.exe"
			"%LocalAppData%\Programs\Vivaldi\Application\vivaldi.exe"
		) do if exist %%V (
			echo Starting Vivaldi...
			start "Vivaldi" %%V
			goto :vivaldi_found
		)
		echo Vivaldi not found
	) else (
		echo Vivaldi is running
	)
	:vivaldi_found
	rem no empty line after label

	query process | find /i "outlook.exe" >nul
	if !errorlevel! equ 1 (
		for %%O in (
			"%ProgramFiles%\Microsoft Office\root\Office16\OUTLOOK.EXE"
			"%ProgramFiles(x86)%\Microsoft Office\Office16\OUTLOOK.EXE"
		) do if exist %%O (
			echo Starting Outlook...
			start "Outlook ^(restore^)" %%O /restore
			goto :outlook_found
		)
		echo Outlook not found
	) else (
		echo Outlook is running
	)
	:outlook_found
	rem no empty line after label

	if exist "%~dp0_reachable-flag" (

		query process | find /i "ms-teams.exe" >nul
		if !errorlevel! equ 1 (
			echo Starting Teams...
			rem find app ID by exploring shell:AppsFolder and create shortcut
			start shell:AppsFolder\MSTeams_8wekyb3d8bbwe^^!MSTeams
		) else (
			echo Teams is running
		)

		query process | find /i "opentouchcon..." >nul
		if !errorlevel! equ 1 (
			echo Starting OpenTouch Conversation...
			start "OpenTouch Conversation" "%ProgramFiles% (x86)\Alcatel-Lucent Enterprise\OpenTouch Conversation\OpenTouchConversation.exe"
		) else (
			echo OpenTouch is running
		)
		where nircmd >nul 2>nul && where timeout >nul 2>nul
		if !errorlevel! equ 0 (
			set /p "=Waiting for OpenTouch.." <nul
			set _opentouch_max_retry=120
			:wait_for_opentouch
			set /a "_opentouch_max_retry-=1"
			set /p "=." <nul
			if !_opentouch_max_retry! leq 0 (
				echo.
				goto stop_wait_for_opentouch
			)
			for /f "tokens=1,8 delims=," %%a in ('tasklist /v /fo csv /nh /fi "ImageName eq OpenTouchConversation.exe"') do (
				if "%%~a" == "OpenTouchConversation.exe" (
					set _opentouch_found=1
					set _opentouch_cpu_time=%%~b
					set _opentouch_cpu_time=!_opentouch_cpu_time::=!
					if !_opentouch_cpu_time! geq 8 (
						echo.
						echo Hide OpenTouch Conversation...
						nircmd win close stitle "OpenTouch Conversation"
						goto stop_wait_for_opentouch
					)
				) else (
					timeout /t 1 >nul
					goto wait_for_opentouch
				)
			)
			if !_opentouch_found neq 1 goto wait_for_opentouch
			:stop_wait_for_opentouch
			rem no empty line after label
		)
	)

	if defined _emul (
		nircmd win hideshow title Intranex
		nircmd win activate title Intranex
		nircmd win settopmost title Intranex 1
		nircmd win move title Intranex -140 0
	)

	date /t >"%~dp0_vpn-flag"

)
