@echo off

netsh interface show interface name="Connexion au r‚seau local" ^
	|find "tat de connexion" ^
	|find "Connect‚" >nul ^
		&& "%ProgramFiles%\Lenovo\HOTKEY\TpFnF5.exe" /wloff ^
		|| "%ProgramFiles%\Lenovo\HOTKEY\TpFnF5.exe" /wlon
