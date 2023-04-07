# coding: utf-8
# Python 3.11.1
'''
    run 1.0

    Démarre accoreconsole.exe

    - Pas installation.

    - Seulement pour Windows

    - Testé avec Windows 10 et Autocad 2015

    :No copyright: (!) 2023 by Frédéric Coulon.
    :No license: Do with it what you want.
'''

import subprocess
import os

def run(name, dir):
    with open(dir + name + ".bat", "w") as f:
        f.write('cd %~dp0\nfor /f "delims=" %%f IN (\'dir /b "*.dwg"\') do accoreconsole.exe /i "%%f" /s %~n0.scr')
    with open(os.devnull,'w') as null:
        process = subprocess.Popen(dir + name + ".bat")
        process.communicate(input='x'.encode())[0]

run('cl0Zet', 'c:\Data\TMP\dwg\\')