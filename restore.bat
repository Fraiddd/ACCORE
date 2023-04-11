rem Restaure les dwg après un passage d'accoreconsole.exe
@echo off
cd "%~dp0"
del "*.dwg" /q
ren "*.bak" "*.dwg"
