@echo off
setlocal enabledelayedexpansion

if not exist "%~dp0_vpn-flag" (

	query process | find /i "vivaldi.exe">nul
	if !errorlevel! equ 1 (echo Starting Vivaldi... & start "Vivaldi" "%LocalAppData%\Programs\Vivaldi\Application\vivaldi.exe")

	query process | find /i "outlook.exe">nul
	if !errorlevel! equ 1 (echo Starting Outlook... & start "Outlook" "%ProgramFiles%\Microsoft Office\root\Office16\OUTLOOK.EXE")

	if exist "%~dp0_reachable-flag" (

		query process | find /i "teams.exe">nul
		if !errorlevel! equ 1 (
			echo Starting Teams...
			rem Teams.exe often leaves command window open with some error logs
			rem start "Teams" "%LocalAppData%\Microsoft\Teams\current\Teams.exe"
			rem This works good but requires nrcmd.exe (excellent tool)
			rem %USERPROFILE%\Documents\PRG\DOS\nircmd exec hide "%LocalAppData%\Microsoft\Teams\current\Teams.exe"
			set _hiddenLauncher=%~dpn0_hiddenLauncher.vbs
			> "!_hiddenLauncher!" (
				echo CreateObject^("Wscript.Shell"^).Run """" ^& "%LocalAppData%\Microsoft\Teams\current\Teams.exe" ^& """", 0, False
			)
			cscript "!_hiddenLauncher!" //nologo
			del "!_hiddenLauncher!"
		)

		query process | find /i "opentouchcon...">nul
		if !errorlevel! equ 1 (
			echo Starting OpenTouch Conversation...
			start "OpenTouch Conversation" "%ProgramFiles% (x86)\Alcatel-Lucent Enterprise\OpenTouch Conversation\OpenTouchConversation.exe"
		)

	)

	date /t > "%~dp0_vpn-flag"

)
