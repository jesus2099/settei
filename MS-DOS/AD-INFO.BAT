@echo off

setlocal enabledelayedexpansion

rem https://devblogs.microsoft.com/scripting/how-can-i-determine-the-ou-the-local-computer-belongs-to/
set _getComputerADInfoVBS=%~dpn0_getComputerADInfo.vbs
>"!_getComputerADInfoVBS!" (
	echo Set objSysInfo = CreateObject^("ADSystemInfo"^)
	echo For each row in Split^(objSysInfo.ComputerName, ","^)
	echo 	Wscript.Echo row
	echo Next
)
cscript /nologo !_getComputerADInfoVBS!
del "!_getComputerADInfoVBS!"

endlocal
