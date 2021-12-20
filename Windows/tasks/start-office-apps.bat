@echo off
setlocal

query process|find /i "outlook.exe">nul
if %errorlevel% equ 1 (echo Starting Outlook & start "Outlook" "%ProgramFiles% (x86)\Microsoft Office\Office16\OUTLOOK.EXE")

query process|find /i "opentouchcon...">nul
if %errorlevel% equ 1 (echo Starting OpenTouch Conversation & start "OpenTouch Conversation" "%ProgramFiles% (x86)\Alcatel-Lucent Enterprise\OpenTouch Conversation\OpenTouchConversation.exe")

query process|find /i "teams.exe">nul
if %errorlevel% equ 1 (
	echo Starting Teams
	rem Teams.exe often leaves command window open with some error logs
	rem start "Teams" "%LocalAppData%\Microsoft\Teams\current\Teams.exe"
	rem This works good but requires nrcmd.exe (excellent tool)
	rem %USERPROFILE%\Documents\PRG\DOS\nircmd exec hide "%LocalAppData%\Microsoft\Teams\current\Teams.exe"
	SET _hiddenLauncher=%~dpn0_hiddenLauncher.vbs
	> "%_hiddenLauncher%" (
		ECHO CreateObject^("Wscript.Shell"^).Run """" ^& "%LocalAppData%\Microsoft\Teams\current\Teams.exe" ^& """", 0, False
	)
	cscript "%_hiddenLauncher%" //nologo
	del "%_hiddenLauncher%"
)
