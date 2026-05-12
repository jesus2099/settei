@echo off
setlocal EnableDelayedExpansion

echo.
echo   °°    °° °°°°°°  °°°    °°       °°    
echo   ±±    ±± ±±   ±± ±±±±   ±±       ±±    
echo   ±±    ±± ±±±±±±  ±± ±±  ±±       Ü±    
echo    ²²  ²²  ²²      ²²  ²² ²²       ßß    
echo     ÛÛÛÛ   ÛÛ      ÛÛ   ÛÛÛÛ       ÛÛ    
echo.

echo Closing PingID...
taskkill /im PingID.exe >nul 2>nul
echo Hiding Pulse Secure...
nircmd win close title "Ivanti Secure Access Client"
