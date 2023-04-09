REM Inscrit le chemin de accoreconsole dans le path Windows.
setlocal EnableDelayedExpansion
for /f "delims=" %%a in ('where acad.exe') do set "ACAD_PATH=%%~dpa"
set "ACAD_PATH=!ACAD_PATH:~0,-1!"
setx Path "%Path%;%ACAD_PATH%"
endlocal
