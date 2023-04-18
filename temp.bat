                    @echo off
chcp 1252
cd C:/Data/TMP/dwg                    
for /f "delims=" %%f IN ('dir /b "*.dwg"')                     do accoreconsole.exe /i "%%f" /s C:/Data/git/lsp/ACCORE/scr/cl0Zet.scr