# ACCORE
![](img/Illu.png)
## Pré-requis

  - Autocad (Version 2013 et +).

  - Une bonne connaissance de ce dernier.

  - Savoir utiliser les lignes de commandes.

  - Des connaissances en Autolisp / Visual-Lisp.

  - Des bonnes notions des scripts Autocad.

## Avertissements

  Attention !!! Ceci est destiné aux Responsables de Bureau d'Études, Cad Manager, gestionnaires de Big Datas, geek Xandarien ...
  Si vous ne comprenez pas ce que vous faites, surtout, ne faites rien. Vous pourriez occasionner des dommages irréparables.

## Installation

  Accoreconsole.exe ne demande pas d'installation, cela est fait en même temps que Autocad.

  Mais une préparation est nécessaire pour lancer directement Accoreconsole avec un .bat.
  
  - Vous devez être administrateur de votre poste.

  - Ajouter l'emplacement d'Accoreconsole.exe dans le PATH Windows. 
    Voir [ici](#_) et [la](#préparation)

  - Modifier les variables systèmes du profil utilisé par Accoreconsole.exe si votre version est 2015 et +.

      - SECURELOAD à 0 (pas sûre que cela serve à quelque chose)

      - Ajouter l'emplacement du dossier contenant les dwgs dans TRUSTEDPATHS.

  - Si vous insérez de l'Autolisp dans votre script, il peut arriver que votre antivirus se réveille. Dans ce cas, approuvez sont exécution.

  
## Présentation

  Depuis la version 2013, toutes les versions AutoCAD (LT comprise) disposent d'une version en ligne de commande qui peut vous aider à accélérer considérablement le traitement par lots des dessins DWG, DWT et DXF en complément d'[ObjectDBX](https://github.com/Fraiddd/ODBX_LIB).

  Accoreconsole est un outil destiné à modifier des centaines de fichiers. Si vous avez moins de cent fichiers, préférer des lanceurs de script comme [scriptpro](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/7xKPXzhEGzvnF4qzy2Ddi9.html), ou [SuperAutoScript](https://www.caderix.com/telechargement_autocad.html).

  Avec l'arrivée de la variable système TRUSTEDPATH avec la version 2014, Autodesk à revue sa copie avec accoreconsole 2015 en ajoutant la possibilité de changer de profil et ainsi de TRUSTEDPATH et cela en toute intimité.

  Non officiellement supporté par Autodesk, il n'y a aucune documentation, alors je vous propose une petite immersion. 

## Quick start

  Pas le temps de tout lire...

  Un .bat lance "accoreconsole.exe" et applique un script .scr à une liste de fichiers.

  Le .bat:

  ```
  @echo off
  rem ACCOR.bat : Utilise accoreconsole.exe pour appliquer un script à un dossier.
  rem Coller ce fichier à côté du .scr dans le dossier cible.
  rem Renommer ce fichier selon le .scr
  cd "%~dp0"
  for /f "delims=" %%f IN ('dir /b "*.dwg"') do accoreconsole.exe /i "%%f" /s "%~n0.scr"

  ```
  Double-cliquez sur le .bat.

# Principes d'utilisation

Vous adapterez ce qui suit à votre environnement et vos besoins (évitez les accents dans les noms de dossiers et fichiers).

## Ligne de commande

Dans le dossier d'installation d'AutoCAD, vous pouvez trouver l'"AccoreConsole.exe". 

Copier/Coller (findfile "accoreconsole.exe") dans la barre de commande Autocad :

vous retourne le chemin d'accoreconsole.exe, ici pour une 2015.

"C:\\Program Files\\Autodesk\\AutoCAD 2015\\accoreconsole.exe"

Copier/Coller ce chemin dans la console Windows (touche Windows + R, tapez "cmd") puis Entrée.

Le simple fait de l'exécuter dans la console, affichera les commutateurs de ligne de commande qui peuvent être utilisés, un exemple d'utilisation et ouvre une session Autocad sur Dessin1.dwg.

![](img/Illu1.png) 

"AccoreConsole.exe" accepte six commutateurs de ligne de commande :

1) /i : permet de spécifier le chemin du fichier de dessin sur lequel exécuter le fichier de script (.scr). (requis)

2) /s : permet de spécifier le chemin d'accès au fichier de script. (requis)

3) /l : Si des packs de langue sont installés, vous avez le choix d'invoquer la version linguistique d'accoreconsole. Les commandes du fichier de script peuvent alors être dans l'une des langues que vous avez installées sur votre système (optionnel, langue utilisé par Autocad par défaut).

4) /isolate : Utilisé pour empêcher les modifications apportées aux variables système d'affecter AutoCAD normal.(optionnel)

5) /readonly : permet de spécifier que le fichier DWG doit être ouvert en lecture seule (optionnel, apparu avec la version 2015)

6) /p[rofile] permet de spécifier le nom d'un profil AutoCAD à utiliser lors de l'ouverture du fichier DWG. (optionnel, apparu avec la version 2015, profil courant dans Autocad par défaut.)

# _
Pour raccourcir nos futurs scripts, en démarrant cmd.exe en tant qu'administrateur nous pouvons ajouter le dossier au Path Windows comme ceci.

``` setx Path "%Path%;C:\Program Files\Autodesk\AutoCAD 2015" ```

Redémarrer la console pour la prise en compte. Maintenant, accoreconsole.exe suffira pour l'appeler dans la console.

Il est conseillé de faire des essais, et de sauvegarder son travail en prévention, même si un .bak est créé. Nous éviterons aussi de modifier des fichiers de façon récursive (dans les sous-dossiers).

Mais avant cela, testons comment nous pouvons dessiner directement dans la console. 

Un rectangle de 100x100.

![](img/Illu2.png)

Plusieurs constats:

  - Double les messages de commande. (plutôt désagréable)

  - Accepte les commandes françaises. (une surprise)

  - Cause en Français.

  - Ne demande pas d'enregistrer avant de quitter (il ne faut donc pas oublier de sauver). 


Pour l'utilisation directe dans la console, je vais m'arrêter là, car c'est en script que c'est le plus intéressant.

## .bat et .scr 

Le principe, le ".bat" démarre accoreconsole.exe dans la console Windows, en lui donnant le chemin du fichier à éditer, puis exécute le script inscrit dans le ".scr".

Les fichiers batch (".bat") et les fichiers de script (".scr") sont des fichiers de commande qui permettent d'automatiser des tâches en exécutant une séquence de commandes dans un ordre précis.

Ce sont de simples fichiers texte ASCII (utf-8 pour le .bat) que vous pouvez éditer avec Notepad ou votre éditeur de texte simple préféré. (Si vous utilisez PowerShell, remplacez .bat par .ps1.)

Plaçons un dwg nommé "Test.dwg", avec un objet et un calque "Test" courant, dans un dossier "C:\Data" que l'on ajoute aux dossiers approuvés par Autocad (important! sinon il n'y aura pas de sauvegarde).

### .scr

Créons un fichier texte dans le même dossier que nous enregistrons en "Test.scr" dans lequel nous écrivons le script.

  - Rendre le calque "0" courant.

  - Faire un zoom étendu.

  - Enregistrer le dessin.

```
(setvar 'clayer "0")
zoom
et
_qsave

```
Plus d'infos sur l'écriture des ".scr" [l'aides des développeurs.](https://help.autodesk.com/view/OARX/2019/FRA/?guid=GUID-95BB6824-0700-4019-9672-E6B502659E9E) 

Et quelques exemples [ici](scr/)

Si vous éditez des DXF, il faut ajouter 2 espaces sur 2 lignes après _qsave et il sera enregistré en .dwg.

Les raccourcis (acad.pgp) ne sont pas pris en compte.

Vous pouvez utiliser de l'Autolisp, mais pas les API's externes. Si vous voulez utiliser un lisp complexe un l'intérieur d'un script vous risquez de rencontrer des problèmes de synchronisation.

Séparer les taches entre Accoreconsole et [ObjectDBX](https://github.com/Fraiddd/ODBX_LIB) est parfois la meilleure solution.

### .bat

Puis le "Test.bat".

Qui lance accoreconsole.exe, avec le dessin "C:\Data\Test.dwg" et applique le script "C:\Data\Test.scr".

```accoreconsole.exe /i C:\Data\Test.dwg /s C:\Data\Test.scr```

Si les chemins contiennent des espaces, il faut les entourer par des guillemets.

Si vous n'utilisez jamais de ".bat", vous pouvez vérifier avec un clic droit/Propriétés que le type de fichiers est bien "Fichier de commande Windows (.bat)". Si ce n'est pas le cas, ouvrez cmd.exe en tant qu'administrateur et saisissez ceci et fermez la console.
```
assoc .bat=cmdfile
ftype cmdfile=C:\Windows\System32\cmd.exe /k "%1" %*
```
On double clic sur Test.bat

La console s'ouvre pendant une seconde et se referme.

Un fichier .bak est apparu. Si cela procure une sécurité, attention, cela double aussi la place que prend votre dossier s' il ne contenais pas de .bak. Si vous voulez ne pas avoir de .bak, changer cette variable ISAVEBAK à 0.

Si on ouvre Test.dwg, le calque courant est "0" et un zoom étendu à bien été effectué.

Voyons maintenant comment modifier tous les dwg d'un dossier.

Pour cela nous utiliserons trois solutions.

  - Une boucle dans le .bat avec FOR IN DO.

  - Un programme Autolisp.

  - Un programme Python.

### [FOR IN DO]

Créer un dossier contenant une dizaine de dwg. Y placer vos .bat et .scr qu'on renomme cl0Zet.bat cl0Zet.scr.

Toujours pour alléger l'écriture, nous allons placer le "pointeur" de la console sur le dossier ou se trouve le .bat avec la commande 'cd %~dp0' puis lancer notre script.

%~dp0 correspond au dossier ou ce situe le .bat
%~n0 correspond au nom du .bat qui s'exécute.

Donc dans le .bat

```
cd "%~dp0"

for /f "delims=" %%f IN ('dir /b "*.dwg"') do accoreconsole.exe /i "%%f" /s "%~n0.scr"

```

Pour les détails d'utilisation de la commande FOR et dir, voici un [lien](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for).

Si vraiment vous voulez allez aussi dans les sous-dossiers, il faut ajouter /s après dir.

Rien à changer dans le scr.

Double-cliquez sur le .bat, la console s'ouvre le temps que tous les fichiers soient traités.

Si certains apprécient l'apparition de la console, ce n'est pas mon cas. On verra qu'en Autolisp et Python nous pouvons la cacher.

## Autolisp / Visual-Lisp

Pour lancer accoreconsole.exe directement en Autolisp (sans .bat)

```
(command "start" "accoreconsole.exe /i c:\\Data\\TMP\\dwg\\Test.dwg /s c:\\Data\\TMP\\dwg\\cl0Zet.scr")

```
Non recommandé !!! Dans une boucle foreach

```
(setq path "c:\\Data\\TMP\\dwg\\")
(foreach file (vl-directory-files path "*.dwg")
  (command "start" (strcat "accoreconsole.exe /i "path file" /s " path "cl0Zet.scr"))
)
```
Ici l'accoreconsole s'ouvre autant de fois qu'il y a de fichiers à traiter.

De plus, le lisp s'arrête alors que plein de consoles restent ouvertes tant que le script n'est pas terminé. 

Une horreur ....

Autolisp peut-être utilisé pour lancer le .bat, ce qui est une méthode plus propre.

Si vous collez cela dans votre ligne de commande Autocad.

```
(command "_shell" "c:\\Data\\TMP\\dwg\\cl0Zet.bat")

```
Vous lancer le ".bat".

Pour avoir plus de contrôles sur l'ouverture de la console nous pouvons utiliser cette fonction.

```
(defun run (file / objWS ret)
    (setq ret T)
    ; Check the existence of the file. 
    (if (findfile file) 
        ; Check the raising of an exception.
        (if (vl-catch-all-error-p 
                (vl-catch-all-apply 'vlax-invoke-method 
                    (list
                        ; Creation of the object "WScript.Shell".
                        (setq objWS (vlax-get-or-create-object "WScript.Shell"))
                         "Run"           ; String, command line to execute.
                          file           ; String, file .bat
                          0              ; Int, 0 to 10, 0 -> Hides the window and activates another window.
                          :vlax-true     ; Boolean, Waits for the end before carrying out the continuation.
                    )
                )
            )   
            (setq ret "Invalid file")
            ; Release the object "WScript.Shell".
            (vlax-release-object objWS)
        )
      (setq ret "File not found")
    )
    ret
)

```
On l'utilise de cette manière (run "c:\\Data\\TMP\\dwg\\cl0Zet.bat")

La console n'apparaît pas, mais fait tout de même le travail.

Un exemple d'utilisation avec un environnement différent.

Ici les .scr sont dans un dossier. Le .bat sera écrit par le lisp.

A partir de là, plus besoin que le dossier de dessins soit approuvé par Autocad, et la variable système SECUREPATH est ignorée.

```
(defun c:accore (/ dir scr bat dirbat cpt)
    (setq dirbat "c:\\Data\\TMP\\temp.bat") 
    (if (and        
          (setq dir (acet-ui-pickdir "Choose the folder containing the DWGs" "c:\\"))
          (setq cpt (length (vl-directory-files dir "*.dwg" 1))); 
          (setq scr (getfiled "Choose a Script" "c:\\Data\\scr\\" "scr" 4))
        )
        (progn
            (setq bat (open dirbat "w"))
            (write-line (strcat 
                "@echo off\nchcp 1252\ncd \""
                dir 
                "\"\nfor /f \"delims=\" %%f IN ('dir /b \"*.dwg\"') do accoreconsole.exe /i \"%%f\" /s \"" 
                scr 
                "\"\n")
                bat)
            (close bat)
            (if (run dirbat)
                (princ (strcat "\nSuccessful processing for "(itoa cpt)" files."))
                (princ "\nProcessing Failure. Check your script.")
            )
        )
        (princ "\n->Abort, or Unknown Error.<-")
    )
    (princ)
)

```

CHCP 1252 à été rajouté au .bat pour éviter des erreurs dues aux éventuels accents, plutôt que de convertir le .bat en utf-8.

## Python

Ici, pas besoin que Autocad soit démarré, juste installé ainsi que Python.

Pourquoi utiliser Python?

Je répondrais pourquoi pas? C'est pour donner un exemple d'utilisation avec un autre langage.

Vous pouvez aussi utiliser le VBA ou .NET, mais ce n'est pas aussi simple qu'en Python de lancer un SubProcess.

Le lanceur de base:

```
import os

os.startfile("c:\Data\TMP\dwg\cl0Zet.bat")

```
Le lanceur propre, sans la console (mais le déroulement des commandes apparaît dans le terminal Python)

```
import subprocess
import os

with open(os.devnull,'w') as null:
    process = subprocess.Popen("c:\Data\TMP\dwg\cl0Zet.bat")
    process.communicate(input='x'.encode())[0]

```
Des détails sur l'utilisation des [subprocess](https://peps.python.org/pep-0324/).


Nous allons pouvoir, tout comme nous pouvons le faire en Autolisp, "enrober" notre lanceur par des invites utilisateurs, des compteurs et une gestion des erreurs.

```
from tkinter import Tk, filedialog
from subprocess import Popen
from os import path, listdir, devnull


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
```


# Pour allez plus loin

  ## Préparation

  L'inscription de chemin d'accoreconsole dans le PATH Windows est nécessaire.
  
  Pour éviter d'éditer les fichiers ".bat", si on change d'Autocad ou de poste par exemple, voici un ".bat" qui s'en charge.

  ```
  REM Inscrit le chemin de accoreconsole dans le path Windows.
  setlocal EnableDelayedExpansion
  for /f "delims=" %%a in ('where acad.exe') do set "ACAD_PATH=%%~dpa"
  set "ACAD_PATH=!ACAD_PATH:~0,-1!"
  setx Path "%Path%;%ACAD_PATH%"
  endlocal

  ```

## .scr

  Les commandes Autocad utilisables dans les scripts envoyés dans accoreconsole sont disponibles [ici](https://through-the-interface.typepad.com/files/Working%20Core%20Console%20commands.txt).


(Edition en cours...)


## Root

  https://www.houseofbim.com/posts/son-of-a-batch-autocad-core-console-through-lisp/

  https://through-the-interface.typepad.com/through_the_interface/2012/02/the-autocad-2013-core-console.html

  https://www.cadtutor.net/forum/topic/44080-up-and-running-with-the-2013-core-console/
  