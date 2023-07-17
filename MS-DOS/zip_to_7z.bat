@echo off
rem edit of https://superuser.com/a/645821/387650
for %%F in (*.zip) do (
	echo. & call "%~dp0banner.bat" Extract "%%F"
	"%ProgramFiles%\7-Zip\7z.exe" x -y -o"%%F_tmp" "%%F" *
	pushd "%%F_tmp"
	echo. & call "%~dp0banner.bat" Compress "%%~nF.7z"
	"%ProgramFiles%\7-Zip\7z.exe" a -y -r -t7z -mx9 "..\%%~nF.7z" *
	popd
	rmdir /s /q "%%F_tmp"
)
