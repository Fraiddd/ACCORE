# coding: utf-8
# Python 3.11.3
'''
    ACCORE 1.0

    Launch accoreconsole.exe

    - No install

    - Only for Windows

    - Tested with Windows 10 and Autocad 2015

    :No copyright: (!) 2023 by Frédéric Coulon.
    :No license: Do with it what you want.
'''
from tkinter import Tk, filedialog
from subprocess import Popen
from os import path, listdir, devnull, getcwd


def accore():
    bat = getcwd() + "/temp.bat"
    # Files explorer
    root = Tk()
    # Hides the root window.
    root.withdraw()
    # Select DWG directory.
    dwg_path = filedialog.askdirectory(initialdir = 'c:/',
                                        title = 'Select DWG directory')
    if dwg_path:
        # Select SCR file.
        scr = filedialog.askopenfilenames(initialdir = 'c:/',
                                      title = 'Select SCR file',
                                      filetypes = [('SCR files', '*.scr')])[0]
        # Number of dwgs in the directory
        nbdwg = len([f for f in listdir(dwg_path) 
                        if path.isfile(path.join(dwg_path, f)) 
                        and f.endswith('.dwg')])
    if scr and nbdwg > 0:
        try:
            # Write the .bat.
            with open(bat, "w") as f:
                f.write(f'\
                    @echo off\nchcp 1252\ncd {dwg_path}\
                    \nfor /f "delims=" %%f IN (\'dir /b "*.dwg"\') \
                    do accoreconsole.exe /i "%%f" /s {scr}')
            try:
                # Launch the .bat.
                with open(devnull,'w') as null:
                    process = Popen(bat)
                    process.communicate(input='x'.encode())[0]
                print(f"\nSuccessful processing for {nbdwg} files.")
            except:
                print("\nProcessing Failure. Check your script.")
        except:
            print("\nWriting Failure. Check your permissions.")
    else:
        print("\n->Abort, no dwg or Unknown Error.<-")

accore()