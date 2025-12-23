@echo off
setlocal EnableDelayedExpansion

taskkill /im PingID.exe >nul 2>nul
nircmd win close title "Ivanti Secure Access Client"

if not exist "%~dp0_vpn-flag" (

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
	if exist "%~dp0_reachable-flag" (
		query process | find /i "opentouchcon..." >nul
		if !errorlevel! equ 1 (
			echo Starting OpenTouch Conversation...
			start "OpenTouch Conversation" "%ProgramFiles% (x86)\Alcatel-Lucent Enterprise\OpenTouch Conversation\OpenTouchConversation.exe"
		) else (
			echo OpenTouch is running
		)
	)

	date /t >"%~dp0_vpn-flag"

)
