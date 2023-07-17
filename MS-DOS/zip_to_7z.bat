@echo off
rem edit of https://superuser.com/a/645821/387650
for %%F in (*.zip) do (
	"C:\Program Files\7-Zip\7z.exe" x -y -o"%%F_tmp" "%%F" *
	pushd %%F_tmp
	"C:\Program Files\7-Zip\7z.exe" a -y -r -t7z ..\"%%~nF".7z *
	popd
	rmdir /s /q "%%F_tmp"
)
