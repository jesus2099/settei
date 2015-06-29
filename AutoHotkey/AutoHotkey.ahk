﻿;MButton::AltTabMenu
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
; !alt +shift ^ctrl #win

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

;alt+shift+ctrl+win+a
!+^#SC010::edit

#e::run c:\windows\explorer.exe /select`, %userprofile%\Documents\Sujets, , max
#g::run c:\windows\explorer.exe /select`, c:\git\_ext, , max

<^>!delete::drive, eject

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
+SC00A::sendinput Ç
+SC00B::sendinput À
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
^+SC00A::sendinput Ⅸ
^+SC00B::sendinput Ⅹ
^+SC00C::Ⅺ
^+SC00D::Ⅻ
; trucs japonais (#WIN)
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
return
