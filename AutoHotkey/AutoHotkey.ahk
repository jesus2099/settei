; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

; #z::Run www.autohotkey.com

; ^!n::
; IfWinExist Untitled - Notepad
; 	WinActivate
; else
; 	Run Notepad
; return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

;MButton::AltTabMenu
;WheelDown::AltTab
;WheelUp::ShiftAltTab
;
;::afaik::as far as i know
;::afaicr::as far as i can remember
;::btw::by the way
;::fwiw::for what it’s worth
;::iirc::if i remember correctly
;::imo::in my opinion
;::mb::musicbrainz
;::ohp::official homepage
;::otoh::on the other hand

; #########################################
; rempl. Clavier+ en plus complet et fiable
; #########################################
groupadd notesInbox, Courrier - Courrier en arrivée - IBM Lotus Notes ahk_exe notes2.exe, , , Entrez votre code P&IN
login := "SEKRET"
mdp := "{asc 83}{asc 69}{asc 75}{asc 82}{asc 83}{asc 84}"
mdp2 := "{asc 83}{asc 69}{asc 75}{asc 82}{asc 83}{asc 84}{asc 50}"

; variables de travail
global guillemets := 0
guillemet() {
	if A_TickCount - guillemets > 5000
	{
		sendinput “
		guillemets := A_TickCount
	}
	else
	{
		sendinput ”
		guillemets := 0
	}
}
; -----------------------*-------------- fin var début macros -*--------------------------------------
; !alt +shift ^ctrl #win

; #######################
; TEMP. VRAC COOL (début)
; #######################
;F10::
;	MouseClick, left
;	sendinput {home}{right 7}www.{enter}^+{tab}
;	return
; #######################
; TEMP. VRAC COOL   (fin)
; #######################
; make the scroll lock key (ScrLk) toggle all hotkeys. http://xahlee.info/mswin/autohotkey_examples.html
$ScrollLock::Suspend

; protection souris pétée
;LButton::
;	If (A_TimeSincePriorHotkey < 100) ;hyperclick
;		Return
;	sendinput {LButton down}
;	KeyWait, LButton
;	sendinput {LButton up}
;	Return

;SC010=a
!+^#SC010::edit

;#e::run c:\windows\explorer.exe /select`,%userprofile%\_TD,, max
#e::run c:\windows\explorer.exe /select`,%userprofile%\_TD\sujets,, max

<^>!delete::drive, eject

; #############################
; win7 : TAB hack comme dans XP
; #############################

#IfWinActive, ahk_class CabinetWClass
$backspace::
	ControlGet renamestatus,Visible,,Edit1,A
	ControlGetFocus focussed, A
	if (renamestatus!=1&&(focussed="DirectUIHWND3"||focussed="SysTreeView321")) {
		sendinput !{up}
	} else {
		sendinput {backspace}
	}
#IfWinActive
return

; #############################
; trucs français (<^>!ALTGR ou +SHIFT)
<^>!<::sendinput «{u+00a0}
<^>!+<::sendinput {u+00a0}»{space}
+é::sendinput É
+è::È
SC004::guillemet()
+SC004::sendinput "
SC005::sendinput ’
+SC005::sendinput '
SC007::sendinput ‐
#SC009::sendinput –
#+SC009::sendinput —
+SC00A::Ç
+SC00B::À
<^>!SC010::æ
<^>!+SC010::Æ
<^>!SC018::sendinput œ
<^>!+SC018::sendinput Œ
$?::sendinput {u+00a0}?
$<^>!?::sendinput ?
$SC033::sendinput {u+00a0};
$<^>!SC033::sendinput {u+003b}
$SC034::sendinput {u+00a0}:
$<^>!SC034::sendinput :
$!::sendinput {u+00a0}{u+0021}
$<^>!!::sendinput {u+0021}
+space::sendinput {u+00a0}
; chiffres romains
^+SC002::Ⅰ
^+SC003::Ⅱ
^+SC004::Ⅲ
^+SC005::Ⅳ
^+SC006::Ⅴ
^+SC007::Ⅵ
^+SC008::Ⅶ
^+SC009::Ⅷ
^+SC00A::Ⅸ
^+SC00B::Ⅹ
^+SC00C::Ⅺ
^+SC00D::Ⅻ
; trucs japonais (#WIN)
#SC002::＆
#SC003::〜
#SC006::（
#SC007::）
#,::sendinput 、
#?::sendinput ？
#SC034::：
#!::！
#y::円
#<::＜
#+<::＞
#a::ā
#+a::Ā
#i::ī
#+i::Ī
#u::ū
#+u::Ū
#SC018::sendinput ō
#+SC018::sendinput Ō
^#numpaddot::sendinput ・
; trucs divers
<^>!c::©
<^>!p::℗
<^>!r::®
<^>!m::Ⓜ
<^>!n::№
<^>!s::ß
<^>!t::™
<^>!y::¥
#numpad0::○
#numpad1::↙
#numpad2::↓
#numpad3::↘
#numpad4::sendinput ←
^#numpad4::sendinput ☜
#numpad5::↔
#numpad6::sendinput →
^#numpad6::sendinput ☞
#numpad7::↖
#numpad8::↑
#numpad9::↗
#numpaddiv::／
#numpadmult::sendinput ×
^#numpadmult::sendinput ※
#numpadsub::sendinput {space}—{u+00a0}
#numpadadd::＋
#numpadenter::sendinput ↲
^#numpadenter::sendinput ≠
#numpaddot::sendinput …

;Win + ²	Texte	[F2][][ORIGINE][][Ctrl + V][][ENTREE][][BAS]		
;Win + Maj + P	Texte	Φ		
;Win + Ctrl + ESPACE	Texte	　		
;iWin + Ctrl + 0 (PAVE NUM.)	Texte	[Ctrl + V][]-1		
;Win + Ctrl + 1 (PAVE NUM.)	Texte	[Ctrl + V][]-01[][ENTREE]		
;Win + Ctrl + 2 (PAVE NUM.)	Texte	[Ctrl + V][]-02[][ENTREE]		
;Win + Ctrl + 3 (PAVE NUM.)	Texte	[Ctrl + V][]-03[][ENTREE]		
;Win + Ctrl + 4 (PAVE NUM.)	Texte	[Ctrl + V][]-04[][ENTREE]		
;Win + Ctrl + 5 (PAVE NUM.)	Texte	[Ctrl + V][]-05[][ENTREE]		
;Win + Ctrl + 6 (PAVE NUM.)	Texte	[Ctrl + V][]-06[][ENTREE]		
;Win + Ctrl + 7 (PAVE NUM.)	Texte	[Ctrl + V][]-07[][ENTREE]		
;Win + Ctrl + 8 (PAVE NUM.)	Texte	[Ctrl + V][]-08[][ENTREE]		
;Win + Ctrl + 9 (PAVE NUM.)	Texte	[Ctrl + V][]-09[][ENTREE]		
;Win + Ctrl + * (PAVE NUM.)	Texte	＊		
;Win + Ctrl + - (PAVE NUM.)	Texte	－		
;Win + Ctrl + . (PAVE NUM.)	Texte	・		
;Win + Ctrl + Maj + à	Texte	Ⅹ		
;Win + Ctrl + Maj + &	Texte	Ⅰ		
;Win + Ctrl + Maj + é	Texte	Ⅱ		
;Win + Ctrl + Maj + "	Texte	Ⅲ		
;Win + Ctrl + Maj + '	Texte	Ⅳ		
;Win + Ctrl + Maj + (	Texte	Ⅴ		
;Win + Ctrl + Maj + -	Texte	Ⅵ		
;Win + Ctrl + Maj + è	Texte	Ⅶ		
;Win + Ctrl + Maj + _	Texte	Ⅷ		
;Win + Ctrl + Maj + ç	Texte	Ⅸ		
;Win + Ctrl + Maj + - (PAVE NUM.)	Texte	±		
;Win + Ctrl + Maj + / (PAVE NUM.)	Texte	÷		
;Win + Ctrl + Maj + =	Texte	Ⅻ		
;Win + Ctrl + Maj + )	Texte	Ⅺ		

#IfWinActive ahk_exe notes2.exe ;-------------------- LOTUS NOTES (rédaction)
^f:: ;rechercher
	send !v
	sleep 100
	sendinput u
	return
;^s:: ;(texte) souligné et vert
;	WinMenuSelectItem, , , texte, souligné
;	WinMenuSelectItem, , , texte, couleur, vert foncé
;	return
^r:: ;(texte) rayé et rouge
	WinMenuSelectItem, , , texte, barré
	WinMenuSelectItem, , , texte, couleur, rouge
	return
^l::
	sendinput ^s
	currentkeydelay := A_KeyDelay
	setkeydelay 100
	send !cy
	setkeydelay currentkeydelay
	return
+^c:: ;rechercher les cc (se placer dans la recherche avant inbox -ctrl+f-)
	ControlClick, IRIS.bmpbutton6, Tristan Daniel - Courrier en arrivée - IBM Lotus Notes, Rechercher dans la vue 'Courrier en arrivée'
	ControlClick, IRIS.bmpbutton16, Tristan Daniel - Courrier en arrivée - IBM Lotus Notes, Rechercher dans la vue 'Courrier en arrivée'
	WinWaitActive, Ajout de critère, , 1
	if not ErrorLevel {
		Control, ChooseString, SendTo, ComboBox6
		Control, ChooseString, ne contient pas, ComboBox7
		ControlSetText, Edit5, tristan
		ControlFocus, Edit5
		Send {enter}
	}
	ControlClick, IRIS.bmpbutton16, Tristan Daniel - Courrier en arrivée - IBM Lotus Notes, Rechercher dans la vue 'Courrier en arrivée'
	WinWaitActive, Ajout de critère, , 1
	if not ErrorLevel {
		Control, ChooseString, SendTo, ComboBox6
		Control, ChooseString, ne contient pas, ComboBox7
		ControlSetText, Edit5, my-id
		ControlFocus, Edit5
		Send {enter}
	}
	ControlClick, IRIS.bmpbutton16, Tristan Daniel - Courrier en arrivée - IBM Lotus Notes, Rechercher dans la vue 'Courrier en arrivée'
	WinWaitActive, Ajout de critère, , 1
	if not ErrorLevel {
		Control, ChooseString, SendTo, ComboBox6
		Control, ChooseString, ne contient pas, ComboBox7
		ControlSetText, Edit5, my-lotus-shortname
		ControlFocus, Edit5
		Send {enter}
	}
	Sleep 100
	ControlClick, IRIS.bmpbutton7, Tristan Daniel - Courrier en arrivée - IBM Lotus Notes, Rechercher dans la vue 'Courrier en arrivée'
	return
+^f:: ;FRANÇAIS(FR)
	sendinput ^y
	winwait ahk_class ibw:0, InfoBox DLL, 1
	if not ErrorLevel {
		coordmode, caret, window
		mouseclick, left, A_CaretX+80, A_CaretY+120
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
		mouseclick, left, A_CaretX+80, A_CaretY+120
		winwait ahk_class ibw:2, InfoBox DLL, 1
		if not ErrorLevel {
			sendinput {home}b{up 17}{enter}{esc}
		}
	}
	return
#IfWinActive ahk_group notesInbox
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
#IfWinActive ahk_exe nlnotes.exe, Entrez votre code P&IN
^F9::
	sendinput %mdp%{enter}
	return
#If not WinActive("ahk_exe notes2.exe") and not WinActive("ARIS Business Architect") and not WinActive("ahk_exe babelmap.exe") and not WinActive("ahk_exe locate32.exe")
^F9::sendinput ^a%login%{tab}%mdp%{enter}
^!F9::sendinput ^aad\a%login%{tab}%mdp%{enter}
^+F9::sendinput ^aad\sekret_login{tab}%mdp2%{enter}

;ctrl+< : enreg.img fermer / ctrl+w : fermer
;^<::
;	sendinput ^s
;	winwait, Enregistrer sous
;	ifwinnotactive, Enregistrer sous, , winactivate, Enregistrer sous
;	winwaitactive, Enregistrer sous
;	sendinput {enter}^w
;return
;<::
;	mouseclick right
;	sendinput s
;	winwait, Save as
;	ifwinnotactive, Save as, , winactivate, Save as
;	winwaitactive, Save as
;	sendinput {enter}^w
;	return



; ######################################
; FOOBAR2000 : AUTOMATICALLY FILL VALUES
; ######################################
#ifwinactive ahk_exe foobar2000.exe
^y::
sendinput !{enter} ; warning, must select some files first
winwait, Properties
ifwinnotactive, Properties, winactivate, Properties
winwaitactive, Properties
sendinput !tf
winwait, Automatically Fill Values
ifwinnotactive, Automatically Fill Values, , winactivate, Automatically Fill Values
winwaitactive, Automatically Fill Values
sendinput o{tab}
sendinput % "$replace($upper(:: %artist% :: %album% :: %title% [:: $meta(album artist) ::]),'',’,...,…,-,‐)"
sendinput {tab 2}
sendinput % ":: %artist% :: %album% :: %title% :: %album artist% ::"
sendinput !o
return

; SUPER FIN ----------------------------------------------------------------------------------------------------------------------
return
return
/*
;virer les liens JASRAC des annotations

#<::
Send, {BACKSPACE}{CTRLDOWN}{LEFT}{LEFT}{LEFT}{LEFT}{LEFT}{LEFT}{LEFT}{CTRLUP}{RIGHT}{CTRLDOWN}{SHIFTDOWN}{HOME}{RIGHT}{RIGHT}{SHIFTUP}{CTRLUP}{DEL}{TAB}{ENTER}
return

;ajouter 1, 2 ou 0 au début du nom du fichier

; renommer un fichier f="1"+f
#&::
Send, {F2}{HOME}1{ENTER}{DOWN}
return

#é::
Send, {F2}{HOME}2{ENTER}{DOWN}
return

#à::
Send, {F2}{HOME}0{ENTER}{DOWN}
return

;Connexion Internet

#i::
Goto, internet_v2

essais := 5
; url := "http://internet-login:internet-password@msdn.microsoft.com/workshop/author/dhtml/reference/dhtml_reference_entry.asp?random=" . A_Now
url := "http://internet-login:internet-password@10.162.125.73/" . A_Now
tmp := "C:\Temp\connect.tmp"

msg := "Connexion à Internet"

essaismax := essais
taille := -1
while ( essais > 0 && !(taille > 0) ) {
  TrayTip
  TrayTip, %msg%, % "Connexion en cours... (" . essaismax-essais+1 . ")", , 1
;  if (essais > 1)
;    Menu, Tray, Icon, Shell32.dll, 89
;  else
    Menu, Tray, Icon, D:\Tristan\PRG\i\VirtuaWin\VirtuaWin.exe, % essaismax-essais+1+12
  FileMove, %tmp%, % SubStr(tmp, 1, StrLen(tmp)-4)".bak", 1
  UrlDownloadToFile, %url%, %tmp%
  FileGetSize, taille, %tmp%
  FileReadLine, ligne, %tmp%, 6
  ;MsgBox, "%ligne%"
  if (ligne == "<title>Notification: Gateway Timeout</title>") {
	;MsgBox, ng
    taille := -1
  } else {
  	;MsgBox, ok
  }
  essais := essais -1
}
TrayTip
if (taille > 0) {
  TrayTip, %msg%, % "OK en " . essaismax-essais . " essai(s)", , 1
  Menu, Tray, Icon, *
} else {
  TrayTip, %msg%, NG après %essaismax% essai(s), , 3
  Menu, Tray, Icon, Shell32.dll, 110
}

internet_v2:
Menu, Tray, Icon, Shell32.dll, 44
IfWinExist, http://10.162.125.73/ - Microsoft Internet Explorer
{
	WinClose
}
Run, "%programfiles%\Internet Explorer\IEXPLORE.EXE" http://10.162.125.73,, Min
WinWait, Connecter à 10.162.125.73,, 16
WinActivate, Connecter à 10.162.125.73
IfWinExist, Connecter à 10.162.125.73
{
	Send, internet-login{TAB}internet-password{ENTER}
}
WinWait, http://10.162.125.73/ - Microsoft Internet Explorer, Not Implemented, 2
IfWinExist, http://10.162.125.73/ - Microsoft Internet Explorer
{
	WinClose
}
Menu, Tray, Icon, *
return

; #########################################
;    LOTUS NOTES
; #########################################
; perso vue
#v::
Send !vv
WinWait, Personnaliser la vue, 
IfWinNotActive, Personnaliser la vue, , WinActivate, Personnaliser la vues, 
WinWaitActive, Personnaliser la vue, 
; défaut
Send !p
Sleep 100
Send o{tab 2}
; follow up
Send !l1+{tab 2}{down}
; qui
Send !l14+{tab 2}{down}
; replied to
Send !l1+{tab 2}{down}
; date
Send !l6+{tab 2}{down}
; heure
Send !l3+{tab}{down}
; taille
Send !l3+{tab 2}{down}
; objet
Send !l100
;
Send !e{HOME}!i{HOME}{ENTER}
return

; archiver tout (win+shift+a)
#+a::
Send, {CTRLDOWN}t{CTRLUP}
; archiver sélectionnés (win+a)
#a::
Send, {ALTDOWN}t{ALTUP}{down}{right}{enter}{enter}
return

; Recevoir courrier
;$#F9::
;IfWinNotActive, Tristan Daniel - Inbox - Lotus Notes
;{
;	Send {#F9}
;	return
;}
;WinWait, Tristan Daniel - Inbox - Lotus Notes
;Send, {ALTDOWN}f{ALTUP}ll
;WinWait, Réplication de Tristan Daniel, 
;IfWinNotActive, Réplication de Tristan Daniel, , WinActivate, Réplication de Tristan Daniel, 
;WinWaitActive, Réplication de Tristan Daniel, 
;Send, re{ENTER}
;WinWait, Tristan Daniel - Inbox - Lotus Notes, 
;IfWinNotActive, Tristan Daniel - Inbox - Lotus Notes, , WinActivate, Tristan Daniel - Inbox - Lotus Notes, 
;WinWaitActive, Tristan Daniel - Inbox - Lotus Notes, 
;Send, {CTRLDOWN}{END}{CTRLUP}
return
; #########################################
;  FIN  LOTUS NOTES
; #########################################
; test
;#+t::

;Menu, Tray, Icon, Shell32.dll, 44
;Send, 1991{tab}12{tab}8{tab}1991{tab}12{tab}8{enter}
;return

;Send, {CTRLDOWN}w{CTRLUP}
;Sleep, 100
;Send, {CTRLDOWN}{TAB}{CTRLUP}
;WinWaitActive, Confirm edit removal, 
;;cancelling in favour of release [AR]
;Send, {ctrldown}v{ctrlup}{TAB}{ENTER}

;Send, {f2}{home}{right 3}{del 20}{enter}{down}
;Send, {F2}{HOME}{RIGHT}{RIGHT}{DEL}{ENTER}{DOWN}
;Send, {F2}{HOME}2009{ENTER}{DOWN}
;DELETED NONSENSE
;Send, {F8}{CTRLDOWN}{LEFT}{SHIFTDOWN}{LEFT}{CTRLUP}{LEFT}{SHIFTUP}{DEL}{ENTER}

;MouseClick, right
;Sleep, 100
;Send, y
;Send, {CTRLDOWN}t{CTRLUP}
;WinWait, Speed Dial - Opera, 
;IfWinNotActive, Speed Dial - Opera, , WinActivate, Speed Dial - Opera, 
;WinWaitActive, Speed Dial - Opera, 
;Send, {CTRLDOWN}v{CTRLUP}{HOME}{CTRLDOWN}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{CTRLUP}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{RIGHT}{SHIFTDOWN}{END}{SHIFTUP}.jpg{ENTER}
;Sleep, 200
;Send, {CTRLDOWN}{SHIFTDOWN}{TAB}{SHIFTUP}{CTRLUP}
return
