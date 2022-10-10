reg add HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\foobar2000.enqueue /ve /d "&Enqueue in foobar2000"
reg add HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\foobar2000.enqueue /v "Icon" /d "%%LocalAppData%%\Programs\foobar2000\foobar2000.exe"
reg add HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\foobar2000.enqueue\command /ve /d "\"%LocalAppData%\Programs\foobar2000\foobar2000.exe\" /add \"%%1\""

reg add HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\foobar2000.play /ve /d "&Play in foobar2000"
reg add HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\foobar2000.play /v "Icon" /d "%%LocalAppData%%\Programs\foobar2000\foobar2000.exe"
reg add HKEY_CURRENT_USER\SOFTWARE\Classes\Directory\shell\foobar2000.play\command /ve /d "\"%LocalAppData%\Programs\foobar2000\foobar2000.exe\" \"%%1\""

pause
