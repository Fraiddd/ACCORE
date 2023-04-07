cd "%~dp0"
for /f "delims=" %%f IN ('dir /b "*.dwg"') do accoreconsole.exe /i "%%f" /s "%~n0.scr"