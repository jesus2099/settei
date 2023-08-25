@echo off
setlocal enableDelayedExpansion

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

ipconfig | findstr /rc:"^   Suffixe DNS propre … la connexion.*: numericable\.fr!CR!*!LF!   Adresse IPv6 de liaison locale.*: fe80::.*!CR!*!LF!   Adresse IPv4.*: 192\.168\.0\..*!CR!*!LF!   Masque de sous-r‚seau.*: 255\.255\.255\.0!CR!*!LF!   Passerelle par d‚faut.*: 192\.168\.0\.1$" >>"%~dpn0.log"
set _home=!errorlevel!

:EnableDomainCreds
if !_home! equ 0 (
	echo.
	echo ßÛÛßßÛÜ                               ÛÛ                ÜÜÛßßßÜÛ                     ßÛÛ         
	echo  ÛÛ   ÛÛ    ÜÜÜ   ÜÜ ÜÜ ÜÜ    ÜÜÜÜ   ÜÜÜ  ÜÜ ÜÜÜ      ÜÛß     ß  ÜÜÜ ÜÜ    ÜÜÜÜ    ÜÜ ÛÛ   ÜÜÜÜ  
	echo  ÛÛ    ÛÛ ÜÛ  ßÛÜ  ÛÛ ÛÛ ÛÛ  ßß ÜÛÛ   ÛÛ   ÛÛ  ÛÛ     ÛÛ          ÛÛß ßß ÜÛÜÜÜÛÛ Üß  ßÛÛ  ÛÛÜ ß  
	echo  ÛÛ    ÛÛ ÛÛ   ÛÛ  ÛÛ ÛÛ ÛÛ  ÜÛß ÛÛ   ÛÛ   ÛÛ  ÛÛ     ßÛÜ      Ü  ÛÛ     ÛÛ      ÛÜ   ÛÛ  Ü ßÛÜÜ 
	echo ÜÛÛÜÜÜÛß   ßÛÜÜÛß ÜÛÛ ÛÛ ÛÛÜ ßÛÜÜßÛß ÜÛÛÜ ÜÛÛÜ ÛÛÜ     ßßÛÜÜÜÜß  ÜÛÛÜ     ßÛÜÜÜß ßÛÜÜßÛÛÜ ÛßÜÜÛß 
	echo.
	reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v DisableDomainCreds >>"%~dpn0.log"
	reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v DisableDomainCreds | findstr /c:"DisableDomainCreds    REG_DWORD    0x1"
	if !errorlevel! equ 0 (
		echo.
		echo ADMINISTRATOR NEEDED to re-ENABLE DOMAIN CREDS ^(allow saving network credentials^)...
		echo.
		sleep 1
		(
			rem runas reg add does not work
			rem Based on: https://social.technet.microsoft.com/Forums/ie/en-US/792eeec7-0c8e-4e10-a56c-a896ba6684b5/windows-credentials-have-been-disabled-by-administrator-cant-enable#5b99b417-01e1-484d-9439-b49a118dc2d1-isAnswer
			echo Windows Registry Editor Version 5.00
			echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
			echo "DisableDomainCreds"=dword:00000000 ; enable = 00000000, disable = 00000001
		) >"%~dpn0.reg"
		regedit /s "%~dpn0.reg"
		reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v DisableDomainCreds >>"%~dpn0.log"
		reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v DisableDomainCreds | findstr /c:"DisableDomainCreds    REG_DWORD    0x1"
		if !errorlevel! equ 0 (
			choice /c yn /d y /t 128 /m "Saving Domain Creds is still disabled. Do you want to retry"
			if !errorlevel! equ 1 goto EnableDomainCreds
		)
		del "%~dpn0.reg"
		reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /v DisableDomainCreds >>"%~dpn0.log"
	)
)
