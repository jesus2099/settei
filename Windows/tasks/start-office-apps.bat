@echo off
setlocal enabledelayedexpansion

taskkill /im PingID.exe >nul 2>nul

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
		:vivaldi_found
		rem nop
	)

	query process | find /i "outlook.exe" >nul
	if !errorlevel! equ 1 (
		for %%O in (
			"%ProgramFiles%\Microsoft Office\root\Office16\OUTLOOK.EXE"
			"%ProgramFiles(x86)%\Microsoft Office\Office16\OUTLOOK.EXE"
		) do if exist %%O (
			start "Outlook ^(restore^)" %%O /restore
			goto :outlook_found
		)
		echo Outlook not found
		:outlook_found
		echo Starting Outlook...
	)

	if exist "%~dp0_reachable-flag" (

		query process | find /i "ms-teams.exe" >nul
		if !errorlevel! equ 1 (
			echo Starting Teams...
			rem find app ID by exploring shell:AppsFolder and create shortcut
			start shell:AppsFolder\MSTeams_8wekyb3d8bbwe^^!MSTeams
		)

		query process | find /i "opentouchcon..." >nul
		if !errorlevel! equ 1 (
			echo Starting OpenTouch Conversation...
			start "OpenTouch Conversation" "%ProgramFiles% (x86)\Alcatel-Lucent Enterprise\OpenTouch Conversation\OpenTouchConversation.exe"
		)

	)

	date /t >"%~dp0_vpn-flag"

)
