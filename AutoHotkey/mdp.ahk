;   protéger : git update-index --assume-unchanged mdp.ahk
; déprotéger : git update-index --no-assume-unchanged mdp.ahk

login := "SEKRET"
mdp := "{asc 83}{asc 69}{asc 75}{asc 82}{asc 83}{asc 84}"

; -----------------------*-------------- fin var début macros -*--------------------------------------

menu, tray, icon, shell32.dll, 105
menu, tray, tip, %login%`nad\%login%

; !alt +shift ^ctrl #win
#IfWinActive ahk_exe nlnotes.exe, Entrez votre code P&IN
^F9::
	sendinput %mdp%{enter}
	return
#If not WinActive("ahk_exe notes2.exe") and not WinActive("ARIS Business Architect") and not WinActive("ahk_exe babelmap.exe") and not WinActive("ahk_exe locate32.exe")
^F9::sendinput ^a%login%{tab}%mdp%{enter}
^!F9::sendinput ^aad\%login%{tab}%mdp%{enter}
^+F9::sendinput ^a%mdp%{enter}

return
