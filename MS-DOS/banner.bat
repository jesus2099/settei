@echo off
setlocal enabledelayedexpansion

rem check how many columns the current terminal displays
for /f "skip=1 tokens=2 delims=:" %%A in ('mode con^|findstr /rc:"[0-9]$"') do (
	set _cols=%%A
	set _cols=!_cols: =!
	goto cols_checked
)
:cols_checked

set _text=%*
set _text_length=0

:buildline

if not defined _text goto show_banner

set _text=%_text:~1%
set _topline=%_topline%Ä
set _bottomline=%_bottomline%Í
set /a "_text_length=_text_length+1"

goto buildline

:show_banner

echo.
set /a "_text_length=_text_length+4"
if %_text_length% leq %_cols% (
	rem single line banner
	echo ÚÄ%_topline%Ä¿
	echo ³ %* º
	echo ÀÍ%_bottomline%Í¼
) else (
	rem multiple line banner
	call echo %%_topline:~0,%_cols%%%
	echo %*
	call echo %%_bottomline:~0,%_cols%%%
)
echo.
