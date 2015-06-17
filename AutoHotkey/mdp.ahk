login := "SEKRET"
mdp := "{asc 83}{asc 69}{asc 75}{asc 82}{asc 83}{asc 84}"
login2:= "sekrect_login-hahaha"
mdp2 := "{asc 83}{asc 69}{asc 75}{asc 82}{asc 83}{asc 84}{asc 50}"
; -----------------------*-------------- fin var début macros -*--------------------------------------
; !alt +shift ^ctrl #win
#IfWinActive ahk_exe nlnotes.exe, Entrez votre code P&IN
^F9::
	sendinput %mdp%{enter}
	return
#If not WinActive("ahk_exe notes2.exe") and not WinActive("ARIS Business Architect") and not WinActive("ahk_exe babelmap.exe") and not WinActive("ahk_exe locate32.exe")
^F9::sendinput ^a%login%{tab}%mdp%{enter}
^!F9::sendinput ^aad\a%login%{tab}%mdp%{enter}
^+F9::sendinput ^aad\%login2%{tab}%mdp2%{enter}
; ICI, C’EST MÉGA LA FIN
return
return
