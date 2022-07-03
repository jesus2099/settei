@ECHO OFF

REM restart explorer.exe when start menu type search is broken
taskkill /f /im explorer.exe
start explorer.exe
