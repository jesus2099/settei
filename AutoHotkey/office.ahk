
; -----------------------*-------------- fin var début macros -*--------------------------------------
; !alt +shift ^ctrl #win

menu, tray, icon, %programfiles% (x86)\Notes-852\notes.exe

; ############
; network init
; ############

if (RegExMatch(A_IPAddress1, "^192\.168\.1\.\d+$") > 0) {
	; Maison
	if (A_IPAddress2 != "0.0.0.0") {
		; WIFI désactivé
		RunWait, "%programfiles%\Lenovo\HOTKEY\TpFnF5.exe"
	}
	Run, "%userprofile%\desktop\clip.lnk" ; vpn URL
} else {
	; Bureau
	EnvGet, domaine, USERDNSDOMAIN
	RegExMatch(domaine, "\w+\.\w+$", domaine)
	Run, "C:\Program Files (x86)\Vivaldi\Application\vivaldi.exe" http://eservicesrh.%domaine%/
}

; ###################################
; win7 : BACKSPACE hack comme dans XP
; ###################################

#IfWinActive, ahk_class CabinetWClass
$backspace::
	ControlGet renamestatus, Visible, , Edit1, A
	ControlGetFocus focussed, A
	if (renamestatus != 1 && (focussed = "DirectUIHWND3" || focussed = "SysTreeView321")) {
		sendinput !{up}
	} else {
		sendinput {backspace}
	}
#IfWinActive
return

; #############
; TRUCS WINDOWS
; #############

#s::run, explorer S:\Jhia\TELEPHONIE, , max

; SUPER FIN ----------------------------------------------------------------------------------------------------------------------
return
