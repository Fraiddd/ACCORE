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
from tkinter import Tk, filedialog, messagebox as mb
import subprocess
import os


def run():
    bat = "c:/Data/TMP/temp.bat"
    # Files explorer
    root = Tk()
    # Hides the root window.
    root.withdraw()
    dwg_path = filedialog.askdirectory(initialdir = 'c:/Data/TMP',
                                        title = 'Select DWG directory')

    scr = filedialog.askopenfilenames(initialdir = 'c:/Data/git/lsp/ACCORE/scr',
                                      title = 'Select SCR files',
                                      filetypes = [('SCR files', '*.scr')])[0]
    # Write the .bat
    with open(bat, "w") as f:
        f.write(f'\
            @echo off\ncd {dwg_path}\
            \nfor /f "delims=" %%f IN (\'dir /b "*.dwg"\') \
            do accoreconsole.exe /i "%%f" /s {scr}')
    
    with open(os.devnull,'w') as null:
        process = subprocess.Popen(bat)
        process.communicate(input='x'.encode())[0]

run()