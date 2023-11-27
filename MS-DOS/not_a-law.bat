@echo off
setlocal EnableDelayedExpansion

rem > for /r %A in (*.wav) do @not_a-law "%A"
rem %1 is an audio_file.wav
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
if not "%1" == "" (
	sox --info %1 >"%~dpn0_sox.tmp" 2>&1
	findstr /irc:"!CR!*!LF!Channels.* 1!CR!*!LF!Sample Rate.* 8000!CR!*!LF!.*!CR!*!LF!.*!CR!*!LF!.*!CR!*!LF!.*!CR!*!LF!Sample Encoding: 8-bit A-law" "%~dpn0_sox.tmp" >nul
	if !errorlevel! equ 0 goto :eof
	sox --info %1 | findstr /c:Input /c:Sample /c:Channels
	sox --info %1 | findstr /c:Input /c:Sample /c:Channels >>%~n0.log
	echo. >>%~n0.log
) else (
	echo.
	echo Missing parameter:
	echo ^> %~nx0 "audio file.wav"
	echo.
	echo Or you can batch check with:
	echo ^> for /r %%A in ^(*.wav^) do @%~nx0 "%%A"
)
if exist "%~dpn0_sox.tmp" del /q "%~dpn0_sox.tmp"
