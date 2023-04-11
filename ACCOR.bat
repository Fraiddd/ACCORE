rem ACCOR.bat : Utilise accoreconsole.exe pour appliquer un scrpt à un dossier.
rem Coller ce fichier à coté du .scr dans le dossier cible.
rem Renommer ce fichier selon le .scr
cd "%~dp0"
for /f "delims=" %%f IN ('dir /b "*.dwg"') do accoreconsole.exe /i "%%f" /s "%~n0.scr"