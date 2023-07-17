@echo off
setlocal enabledelayedexpansion

set _str=%*

:buildline

if not defined _str goto result

set _str=%_str:~1%
set _topline=%_topline%Ä
set _bottomline=%_bottomline%Í

goto buildline

:result

echo.
echo ÚÄ%_topline%Ä¿
echo ³ %* º
echo ÀÍ%_bottomline%Í¼
echo.
