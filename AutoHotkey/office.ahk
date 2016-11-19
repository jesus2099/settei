groupadd notesInbox, Courrier - Courrier en arrivée - IBM Lotus Notes ahk_exe notes2.exe, , , Entrez votre code P&IN

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
	Run, "%programfiles% (x86)\Internet Explorer\iexplore.exe"
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


#IfWinActive ahk_exe notes2.exe ;-------------------- LOTUS NOTES (rédaction)

^f:: ;rechercher
	send !v
	sleep 100
	sendinput u
	return

^s:: ;(texte) souligné et vert
	WinMenuSelectItem, , , Texte, Souligné
	WinMenuSelectItem, , , Texte, Couleur, Vert foncé
	return

^r:: ;(texte) rayé et rouge
	WinMenuSelectItem, , , Texte, Barré
	WinMenuSelectItem, , , Texte, Couleur, Rouge
	return

^l::
	sendinput ^s
	currentkeydelay := A_KeyDelay
	setkeydelay 100
	send !cy
	setkeydelay currentkeydelay
	return

+^f:: ;FRANÇAIS(FR)
	sendinput ^y
	winwait ahk_class ibw:0, InfoBox DLL, 1
	if not ErrorLevel {
		coordmode, caret, window
		mouseclick, left, A_CaretX + 80, A_CaretY + 120
		winwait ahk_class ibw:2, InfoBox DLL, 1
		if not ErrorLevel {
			sendinput {home}g{up 3}{enter}{esc}
		}
	}
	return

+^e:: ;ENGLISH(UK)
	sendinput ^y
	winwait ahk_class ibw:0, InfoBox DLL, 1
	if not ErrorLevel {
		coordmode, caret, window
		mouseclick, left, A_CaretX + 80, A_CaretY + 120
		winwait ahk_class ibw:2, InfoBox DLL, 1
		if not ErrorLevel {
			sendinput {home}b{up 17}{enter}{esc}
		}
	}
	return

#IfWinActive ahk_group notesInbox ;-------------------- LOTUS NOTES (inbox)

$F9::
	currentkeydelay := A_KeyDelay
	setkeydelay 100
	send {F9}!flr
	setkeydelay currentkeydelay
	winwait Réplication de Tristan Daniel
	ifwinnotactive Réplication de Tristan Daniel, , winactivate, Réplication de Tristan Daniel
	winwaitactive Réplication de Tristan Daniel
	sendinput !e{enter}
	return

; SUPER FIN ----------------------------------------------------------------------------------------------------------------------
return
