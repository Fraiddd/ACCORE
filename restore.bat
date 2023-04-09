@echo off
cd "%~dp0"
del "*.dwg" /q
ren "*.bak" "*.dwg"
