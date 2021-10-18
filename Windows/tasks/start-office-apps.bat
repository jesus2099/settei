@echo off

query process|find /i "outlook.exe">NUL
if %errorlevel% equ 1 (echo Starting Outlook & start "Outlook" "%ProgramFiles% (x86)\Microsoft Office\Office16\OUTLOOK.EXE")

query process|find /i "opentouchcon...">NUL
if %errorlevel% equ 1 (echo Starting OpenTouch Conversation & start "OpenTouch Conversation" "%ProgramFiles% (x86)\Alcatel-Lucent Enterprise\OpenTouch Conversation\OpenTouchConversation.exe")

query process|find /i "teams.exe">NUL
if %errorlevel% equ 1 (echo Starting Teams & start "Teams" "%LocalAppData%\Microsoft\Teams\current\Teams.exe")
