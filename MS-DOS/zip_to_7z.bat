@echo off
rem edit of https://superuser.com/a/645821/387650
for %%F in (*.zip) do (
	"%ProgramFiles%\7-Zip\7z.exe" x -y -o"%%F_tmp" "%%F" *
	pushd "%%F_tmp"
	"%ProgramFiles%\7-Zip\7z.exe" a -y -r -t7z "..\%%~nF.7z" *
	popd
	rmdir /s /q "%%F_tmp"
)
