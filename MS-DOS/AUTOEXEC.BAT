@ECHO off
REM Encoding OEM 850 Western Europe DOS

REM --------------- GESTION TOP MOUMOUTE DES CONNEXIONS RSEAU ------
REM · l'ouverture de la session, v‚rifie la connexion r‚seau filaire.
REM D‚sactive le WIFI si r‚seau filaire OK, l'active sinon.
REM -----------------------------------------------------------------

NETSH interface show interface name="Connexion au r‚seau local" ^
	|FIND "tat de connexion" ^
	|FIND "Connect‚" >nul ^
		&& "%ProgramFiles%\Lenovo\HOTKEY\TpFnF5.exe" /wloff ^
		|| "%ProgramFiles%\Lenovo\HOTKEY\TpFnF5.exe" /wlon
