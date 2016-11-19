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
; !alt +shift ^ctrl #win <^>!altgr

; make the scroll lock key toggle (only this) ahk file. http://xahlee.info/mswin/autohotkey_examples.html
$ScrollLock::
	if (!RegExMatch(A_IPAddress1, "^192\.168\.1\.\d+$") > 0 and !RegExMatch(A_IPAddress2, "^192\.168\.1\.\d+$") > 0) {
		Suspend
	} else { ; let my home KVM receive scrolllocks
		SendInput {ScrollLock}
	}
	Return

; protection souris pétée
;LButton::
;	If (A_TimeSincePriorHotkey < 100) ;hyperclick
;		Return
;	sendinput {LButton down}
;	KeyWait, LButton
;	sendinput {LButton up}
;	Return

;alt+shift+ctrl+win+a
!+^#SC010::edit

; #############
; TRUCS WINDOWS
; #############

#e::run, explorer /select`, %userprofile%\Documents, , max
#g::run, explorer c:\git, , max

; Ouverture de l’URL sélectionnée ou copiée
^#o::
^#f::
^#i::
	URLRegExp := "https?://\S+"
	If (RegExMatch(Clipboard, URLRegExp, url) = 0) {
		ClipboardSaved := ClipboardAll
		SendInput, ^c
		ClipWait, 0
		RegExMatch(Clipboard, URLRegExp, url)
		Clipboard := ClipboardSaved
		ClipboardSaved := ; free up memory from big clipboard content
	}
	If (url != "") {
		If (A_ThisHotkey = "^#o") {
			Run, "%programfiles% (x86)\Opera\opera.exe" %url%
		} Else If (A_ThisHotkey = "^#f") {
			Run, "%programfiles% (x86)\Mozilla Firefox\firefox.exe" %url%
		} Else If (A_ThisHotkey = "^#i") {
			Run, "%programfiles% (x86)\Internet Explorer\iexplore.exe" %url%
		}
	}
	Return

; Basculer l’affichage des fichiers cachés
#h::
	RegRead, HiddenFilesStatus, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
	HiddenFilesStatus := HiddenFilesStatus != 1 ? 1 : 2 ; 1 = show hidden files / 2 = hide hidden files
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, %HiddenFilesStatus%
	WinGetClass, class, A
	If (class In CabinetWClass,ExploreWClass) { ; Explorer
		SendInput, {F5}
;	} Else {
;		PostMessage, 0x111, 28931, , , A ; 0x111 = WM_COMMAND / 28931 = 0x7103 = Refresh (Windows XP)
;		PostMessage, 0x111, 41504, , , A ; 0x111 = WM_COMMAND / 41504 = Refresh (Windows 7)
	}
	Return

<^>!delete::drive, eject

; ##########################
; INTERNATIÖNAZICHE KLÄVIEER
; ##########################

; trucs français
<^>!<::sendinput «{u+202f}
<^>!+<::sendinput {u+202f}»{space}
+SC003::sendinput É
+SC008::sendinput È
SC004::guillemet()
+SC004::sendinput "
SC005::sendinput ’
+SC005::sendinput '
SC007::sendinput ‐
#SC009::sendinput –
#+SC009::sendinput —
+SC00A::sendinput Ç
+SC00B::sendinput À
<^>!SC010::æ
<^>!+SC010::Æ
<^>!SC018::sendinput œ
<^>!+SC018::sendinput Œ
$?::sendinput {u+202f}?
$<^>!?::sendinput ?
$SC033::sendinput {u+202f};
$<^>!SC033::sendinput {u+003b}
$SC034::sendinput {u+202f}:
$<^>!SC034::sendinput :
$!::sendinput {u+202f}{u+0021}
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
^+SC00A::sendinput Ⅸ
^+SC00B::sendinput Ⅹ
^+SC00C::Ⅺ
^+SC00D::Ⅻ

; trucs japonais
#SC002::＆
#SC003::〜
#SC006::（
#SC00C::）
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
