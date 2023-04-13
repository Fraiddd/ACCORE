# ACCORE

## Pré-requis

  - Autocad (Version 2013 et +).

  - Une bonne connaissance de ce derniers.

  - Savoir utiliser les lignes de commandes.

  - Des connaissances en Autolisp / Visual-Lisp.

  - Des bonnes notions des scripts Autocad.

## Avertissements

  Attention !!! Ceci est destiné aux Responsables de bureau d'études, cad manager, gestionnaires de big datas...
  Si vous ne comprenez pas ce que vous faites, surtout, ne faites rien. Vous pourriez occasionner de dommages irréparrables.

  Vous devez être admisnistrateur de votre poste, et travailler dans des dossiers appouvés par Autocad.

## Présentation

  Depuis la version 2013, toutes les versions AutoCAD (LT comprise) disposent d'une version en ligne de commande qui peut vous aider à accélérer considérablement le traitement par lots des dessins DWG, DWT et DXF en complément d'[ObjectDBX](https://github.com/Fraiddd/ODBX_LIB).

  Accoreconsole est un outil destiné à modifier des centaines de fichiers. Si vous avez moins de cent fichiers, préférer des lanceurs de script comme [scriptpro](https://www.autodesk.com/support/technical/article/caas/tsarticles/ts/7xKPXzhEGzvnF4qzy2Ddi9.html), ou [SuperAutoScript](https://www.caderix.com/telechargement_autocad.html).

  Pas officiellement supporté par Autodesk, il n'y a aucune documentation, alors je vous propose une petite immersion. 

## Quick start

  Pas le temps de tout lire...

  Un .bat lance "accoreconsole.exe" et applique un script .scr à une liste de fichiers.

  Le .bat:

  ```
  @echo off
  rem ACCOR.bat : Utilise accoreconsole.exe pour appliquer un scrpt à un dossier.
  rem Coller ce fichier à coté du .scr dans le dossier cible.
  rem Renommer ce fichier selon le .scr
  cd "%~dp0"
  for /f "delims=" %%f IN ('dir /b "*.dwg"') do accoreconsole.exe /i "%%f" /s "%~n0.scr"

  ```
  Double-cliquez sur le .bat.

# Principes d'utilisation

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

3) /l : Si des packs de langue sont installés, vous avez le choix d'invoquer la version linguistique d'accoreconsole. Les commandes du fichier de script peuvent alors être dans l'une des langues que vous avez installées sur votre système (optionnel, langue utilisé par Autocad par defaut).

4) /isolate : utilisé pour empêcher les modifications apportées aux variables système d'affecter AutoCAD normal.(optionnel)

5) /readonly : permet de spécifier que le fichier DWG doit être ouvert en lecture seule (optionnel, apparu avec la version 2015)

6) /p[rofile] permet de spécifier le nom d'un profil AutoCAD à utiliser lors de l'ouverture du fichier DWG. (optionnel, apparu avec la version 2015, profil courant dans Autocad par défaut.)

Pour raccourcir nos futurs scripts, en démarrant cmd.exe en tant qu'administrateur nous pouvons rajouter le dossier au Path Windows comme ceci.

``` setx Path "%Path%;C:\Program Files\Autodesk\AutoCAD 2015" ```

Redémarrer la console pour la prise en compte. Maintenant, accoreconsole.exe suffira pour l'appeler dans la console.

Il est conseillé de faire des essais, et de sauvegarder son travail en prévention, même si un .bak est créer. Nous éviterons aussi de modifier des fichiers de façon récursive (dans les sous-dossiers).

Mais avant cela testons comment nous pouvons dessiner directement dans la console. 

Un rectangle de 100x100.

![](img/Illu2.png)

Plusieurs constats:

  - Accepte les expressions lisp (setvar)

  - Double les messages de commande. (plutôt désagréable)

  - Accepte les commandes françaises. (une surprise)

  - Cause en Français.

  - Ne demande pas d'enregistrer avant de quitter(il ne faut donc pas oublier de sauver). 


Pour l'utilisation directe dans la console, je vais m'arrêter la, car c'est en script que c'est le plus intéressant.

## .bat et .scr 

Le principe, le ".bat" démarre accoreconsole.exe dans la console Windows, en lui donnant le chemin du fichier à éditer, puis exécute le script inscrit dans le ".scr".

Les fichiers batch (".bat") et les fichiers de script (".scr") sont des fichiers de commande qui permettent d'automatiser des tâches en exécutant une séquence de commandes dans un ordre précis.

Ce sont de simples fichiers texte ASCII (utf-8 pour le .bat) que vous pouvez éditer avec Notepad ou votre éditeur de texte simple préféré. (Si vous utilisez PowerShell, remplacez .bat par .ps1.)

Plaçons un dwg nommé "Test.dwg", avec un objet et un calque "Test" courant, dans un dossier "C:\Data" que l'on rajoutera aux dossiers approuvés par Autocad (important! sinon il n'y auras pas de sauvegarde).

Créons un fichier texte dans le même dossier que nous enregistrerons en "Test.scr" dans lequel nous écrivons le script.

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

Si vous éditer des DXF, il faut rajouter 2 espaces sur 2 lignes après _qsave.

Les raccourcis (acad.pgp) ne sont pas pris en compte.

Vous pouvez utiliser de l'Autolisp, mais pas les API's externes.()

Puis le "Test.bat".

Qui lance accoreconsole.exe, avec le dessin "C:\Data\Test.dwg" et applique le script "C:\Data\Test.scr".

```accoreconsole.exe /i C:\Data\Test.dwg /s C:\Data\Test.scr```

Si les chemins contiennent des espaces, il faut les entourer par des guillemets.

Si vous n'utilsez jamais de ".bat", vous pouvez vérifier avec un clic droit/Propriétés que le type de fichiers soit bien "Fichier de commande Windows (.bat)". Si ce n'est pas le cas, ouvrez cmd.exe an tant qu'administrateur et saisissez ceci et fermez la console.
```
assoc .bat=cmdfile
ftype cmdfile=C:\Windows\System32\cmd.exe /k "%1" %*
```
On double clic sur Test.bat

La console s'ouvre pendant une seconde et se referme.

Un fichier .bak est apparu. Si cela procure une sécurité, attention, cela double aussi la place que prend votre dossier si il ne contenais pas de .bak.

Si on ouvre Test.dwg, le calque courant est "0" et un zoom étendu à bien été effectué.

Voyons maintenant comment modifier tout les dwg d'un dossier.

Pour cela nous utiliserons trois solutions.

  - Une boucle dans le .bat avec FOR IN DO.

  - Un programme Autolisp.

  - Un programme Python.

### [FOR IN DO]

Créer un dossier contenant une dizaine de dwg. Y placer vos .bat et .scr qu'on renomme cl0Zet.bat cl0Zet.scr.

Toujours pour alléger l'écriture, nous allons placer le "pointeur" de la console sur le dossier ou se trouve le .bat avec la commande 'cd %~dp0' puis lancer notre script.

%~n0 correspond au nom du .bat qui s'execute.

Donc dans le .bat
```
cd "%~dp0"

for /f "delims=" %%f IN ('dir /b "*.dwg"') do accoreconsole.exe /i "%%f" /s "%~n0.scr"
```

Pour les détails d'utilisation de la commande FOR et dir, voici un [lien](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for).

Si vraiment vous voulez allez aussi dans les sous-dossier il faut rajouter /s après dir.

Rien à changer dans le scr.

Double-cliquez sur le .bat, la console s'ouvre le temps que tous les dossiers soient traités.

Si certain apprécient l'apparition de la console, ce n'est pas mon cas. On verra qu'en Autolisp et Python nous pouvons la cacher.

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

De plus, le lisp s'arrette alors que plein de consoles restent ouvertes tant que le script n'est pas terminé. Une horreur ....

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

La console n'apparaît pas, mais fait le travail tout de même.

## Python

Ici, pas besoin qu'Autocad soit démarré, juste installé ainsi que Python.

Pourquoi utiliser Python?

Je reponderais pourquoi pas?

Le lanceur de base:

```
import os

os.startfile("c:\Data\TMP\dwg\cl0Zet.bat")

```
Le lanceur sans la console (mais le déroulement des commandes apparais dans le terminal Python):

```
import subprocess
import os

with open(os.devnull,'w') as null:
    process = subprocess.Popen("c:\Data\TMP\dwg\cl0Zet.bat")
    process.communicate(input='x'.encode())[0]

```
Des détails sur l'utilisation des [subprocess](https://peps.python.org/pep-0324/).


Nous allons pouvoir, tout comme nous pouvons le faire en Autolisp, "enrober" notre lanceur par des invites utilisateurs, des compteurs et une gestion des erreurs.


# Pour allez plus loin

  L'inscrition de chemin d'accoreconsole dans le PATH Windows est nécéssaire.
  
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

  Les commandes Autocad utilisables dans les scripts envoyés dans accoreconsole sont disponibles sur ce [site](https://through-the-interface.typepad.com/through_the_interface/2012/03/commands-that-work-in-the-autocad-2013-core-console.html).


(Edition en cours...)


## Root

  https://www.houseofbim.com/posts/son-of-a-batch-autocad-core-console-through-lisp/

  https://through-the-interface.typepad.com/through_the_interface/2012/02/the-autocad-2013-core-console.html

  https://www.cadtutor.net/forum/topic/44080-up-and-running-with-the-2013-core-console/
  