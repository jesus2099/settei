@echo off
setlocal enabledelayedexpansion

set _str=%*

:buildline

if not defined _str goto result

set _str=%_str:~1%
set _topline=%_topline%�
set _bottomline=%_bottomline%�

goto buildline

:result

echo.
echo ��%_topline%Ŀ
echo � %* �
echo ��%_bottomline%ͼ
echo.
