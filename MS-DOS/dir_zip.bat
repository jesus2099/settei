@echo off
setlocal EnableDelayedExpansion

echo.
echo ----------------------------------------------------------------------------
echo.
set /p "=.    Date: " <nul&date /t
set /p "=.    Time: " <nul&time /t
echo Location: %cd%
echo  Command: %0 %*
echo.
echo ## %~nx0 ^(version 2023.10.11.2016: %~z0 bytes saved %~t0^) ##
echo.
echo.
echo   :::::::::::::::::::::::::
echo   :: Folders to 7z Ultra ::
echo   ::           jesus2099 ::
echo   :::::::::::::::::::::::::
echo.
echo.
if "%~1" == "" (
	echo Usage
	echo -----
	echo.
	echo.
	echo Compress one folder then delete it:
	echo.
	echo ^> %~nx0 "My Folder"
	echo.
	echo.
	echo Compress several folders then delete them:
	echo.
	echo ^> %~nx0 "My Fold*"
	echo.
	goto:eof
)

echo Locating 7-Zip...
where 7z.exe 2>nul
if !errorlevel! equ 0 (
	set _7z=7z.exe
	goto 7z_found
)
set _7z="%ProgramFiles%\7-Zip\7z.exe"
if not exist !_7z! (
	echo [ERROR] 7-Zip not found
	goto:eof
)
:7z_found
echo Using !_7z!

set _initial_directory="!cd!"
for /d %%A in (%*) do (
	echo.
	echo Compressing "%%A"...
	cd /d "%%A"
	!_7z! u -tzip -r "..\%%A.zip" *.*
	set _7z_ok=!errorlevel!
	cd /d !_initial_directory!
	if !_7z_ok! equ 0 (
		echo Deleting "%%A"...
		rmdir /s /q "%%A"
	)
)
