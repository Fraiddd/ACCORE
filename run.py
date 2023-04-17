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
    # Files explorer
    root = Tk()
    # Hides the root window.
    root.withdraw()
    dwg_path = filedialog.askdirectory(initialdir = 'c:/Data/TMP/dwg',
                                        title = 'Select DWG directory')

    scr = filedialog.askopenfilenames(initialdir = 'c:/Data/git/lsp/ACCORE/scr',
                                      title = 'Select SCR files',
                                      filetypes = [('SCR files', '*.scr')])[0]

    print(dwg_path, scr)

    # with open("c:/Data/TMP/temp.bat", "w") as f:
    #     f.write('@echo off\ncd "%~dp0"\nfor /f "delims=" %%f IN (\'dir /b "*.dwg"\') do accoreconsole.exe /i "%%f" /s "%~n0.scr"')
    # with open(os.devnull,'w') as null:
    #     process = subprocess.Popen(dir + name + ".bat")
    #     process.communicate(input='x'.encode())[0]

run()