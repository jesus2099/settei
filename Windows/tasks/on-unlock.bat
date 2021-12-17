@ECHO OFF

REM restart explorer as sometimes start menu type search is broken otherwise
taskkill /f /im explorer.exe
start explorer.exe

REM Lenovo laptop resets keyboard repeat rate and delay after hibernation and workstation screen lock/unlock
REM https://answers.microsoft.com/en-us/windows/forum/windows_10-other_settings/keyboard-repeat-rate-and-delay-reset-after/5482e452-ce0c-41f0-a67a-49cbcea5618c
REM https://answers.microsoft.com/en-us/windows/forum/windows_10-other_settings/keyboard-repeat-rate-and-delay-reset-after/2bf1fec8-3250-4e51-8fec-3be0e395c645
mode con con rate=31 delay=0
