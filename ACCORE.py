# coding: utf-8
# Python 3.11.3
'''
    ACCORE 1.0

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


def accore():
    bat = "c:/Data/TMP/temp.bat"
    # Files explorer
    root = Tk()
    # Hides the root window.
    root.withdraw()
    # Select DWG directory.
    dwg_path = filedialog.askdirectory(initialdir = 'c:/Data/TMP',
                                        title = 'Select DWG directory')
    # Select SCR file.
    scr = filedialog.askopenfilenames(initialdir = 'c:/Data/scr',
                                      title = 'Select SCR file',
                                      filetypes = [('SCR files', '*.scr')])[0]
    # Write the .bat.
    if dwg_path and scr:
        try:
            nbdwg = len([f for f in os.listdir(dwg_path) if os.path.isfile(os.path.join(dwg_path, f)) and f.endswith('.dwg')])
            with open(bat, "w") as f:
                f.write(f'\
                    @echo off\nchcp 1252\ncd {dwg_path}\
                    \nfor /f "delims=" %%f IN (\'dir /b "*.dwg"\') \
                    do accoreconsole.exe /i "%%f" /s {scr}')
                print(f"\nSuccessful processing for {nbdwg} files.")
            try:
                # Launch the .bat.
                with open(os.devnull,'w') as null:
                    process = subprocess.Popen(bat)
                    process.communicate(input='x'.encode())[0]
            except:
                print("\nProcessing Failure. Check your script.")
        except:
            print("\nWriting Failure. Check your permissions.")
    else:
        print("\n->Abort, or Unknown Error.<-")

accore()