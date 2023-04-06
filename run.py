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
import os, sys, win32com.client


# def run():
#     # bat = ""
#     shell = win32com.client.Dispatch("WScript.Shell")
#     ret = shell.Run("cmd.exe " + "c:\Data\TMP\dwg\cl0Zet.bat", 1)
#     return ret
# run()
os.startfile("c:\Data\TMP\dwg\cl0Zet.bat")