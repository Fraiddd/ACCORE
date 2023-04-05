# ACCORE

Depuis le version 2013, toutes les versions AutoCAD (LT comprise) disposent d'une version en ligne de commande qui peut vous aider à accélérer considérablement le traitement par lots des dessins DWG, DWT et DXF.
Non supporté officiellement par Autodesk, il n'y a pas de documentation, je vous propose donc une petite immersion. 

## Principes d'utilisation
### Ligne de commande

Dans le dossier d'installation d'AutoCAD, vous pouvez trouver le "AccoreConsole.exe". 

Copier/Coller (findfile "accoreconsole.exe") dans la barre de commande Autocad :

vous retourne le chemin d'accoreconsole.exe, Ici pour une 2015.

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

6) /p[rofile] permet de spécifier le nom d'un profil AutoCAD à utiliser lors de l'ouverture du fichier DWG. (optionnel, apparu avec la version 2015)

Pour raccourcir nos futurs scripts, nous pouvons rajouter au Path Windows le dossier comme ceci.

``` setx Path "%Path%;C:\Program Files\Autodesk\AutoCAD 2015" ```

Redémarrer la console pour la prise en compte. Maintenant, accoreconsole.exe suffira pour l'appeler dans la console.

Il est conseillé de faire des essais, et de sauvegarder son travail en prévention, même si un .bak est créer. Nous éviterons aussi de modifier des fichiers de façon récursive (dans les sous-dossiers).

Mais avant cela testons comment nous pouvons dessiner directement dans la console. 

Un rectangle de 100x100.

![](img/Illu2.png)

Plusieurs constats:

  - Accepte les expressions lisp (setvar)

  - Double les messages de Commande. (plutôt désagréable)

  - Accepte les commandes françaises. (une surprise)

  - Cause en Français.

  - Ne demande pas d'enregistrer avant de quitter. 


Pour l'utilisation directe dans la console, je vais m'arretter la, car c'est en script que c'est le plus intérréssant.

## .bat et .scr 

Le principe, le ".bat" démarre accoreconsole dans la console Windows, en lui donnant le chemin du fichier à éditer, puis éxécute le script inscrit dans le ".scr".

Les fichiers batch (".bat") et les fichiers de script (".scr") sont des fichiers de commandes qui permettent d'automatiser des tâches en exécutant une séquence de commandes dans un ordre précis.

Ce sont de simples fichiers texte ASCII (utf-8 pour le .bat) que vous pouvez éditer avec Notepad ou votre éditeur de texte simple préféré. (Si vous utilisez PowerShell, remplacez .bat par .ps1.)

Plaçons un dwg nommé Test.dwg (avec un objet et un calque "Test" courant) dans un dossier "C:\Data" que l'on rajouteras aux dossiers approuvé par Autocad.

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

Les raccourcis (acad.pgp) ne sont pas pris en compte.

Vous pouvez utiliser de l'Autolisp, mais pas les API's externes.()

Puis le "Test.bat".

Qui lance accoreconsole.exe, avec le dessin "C:\Data\Test.dwg" et applique le script "C:\Data\Test.scr".

```accoreconsole.exe /i C:\Data\Test.dwg /s C:\Data\Test.scr```

Si les chemins contiennent des espaces, il faut les entourer par des guillemets.

Si vous n'utilsez jammais de ".bat", vous pouvez vérifier avec un clic droit/Propriétés que le Type de fichiers soit bien "Fichier de commande Windows (.bat)". Si ce n'est pas le cas, ouvrez cmd.exe et saisissez ceci et fermez la console.
```
assoc .bat=cmdfile
ftype cmdfile=C:\Windows\System32\cmd.exe /k "%1" %*
```
On double clic sur Test.bat

La console s'ouvre pendant une seconde et se referme.

Un fichier .bak est apparru.

Si on ouvre Test.dwg, le calque courant est "0" et un zoom étendu à bien été éffectué.

Voyons maintenant comment modifier tout les dwg d'un dossier.

Pour cela nous utiliserons trois solutions.

  - Une boucle dans le .bat avec FOR IN DO.

  - Un programme Autolisp.

  - Un programme Python.

### [FOR IN DO]

Créer un dossier contenant un dizaine de dwg. Y placer vos .bat et .scr qu'on renomme cl0Zet.bat cl0Zet.scr.

Toujours pour alléger l'écriture, nous allons placer le "pointeur" de la console sur le dossier "C:\Data\dwg" avec la commande cd puis lancer notre script. Vous pouvez utiliser votre dossier, si il contient un espace, entouré votre chemin par des guillemets.

Donc dans le .bat
```
cd C:\Data\dwg

for /f "delims=" %%f IN ('dir /b "*.dwg"') do accoreconsole.exe /i "%%f" /s cl0Zet.scr
```

Pour les détails d'utilisation de la commande FOR, voici un [lien](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for). Si vraiment vous voulez allez aussi dans les sous-dossier il faut rajouter /s après dir.

Rien à changer dans le scr.

Double cliquez sur le .bat, la console s'ouvre le temps que tout les dossiers soient traités.

Si certain apprécie l'apparition de la console, ce n'est pas mon cas. On verras qu'en Autolisp nous pouvons la cachée.

### Autolisp / Visual-Lisp

Autolisp peut etre utlisé pour lancer le .bat.

Si vous coller cela dans votre ligne de commande Autocad.
```
(command "_shell" "c:\\Data\\TMP\\dwg\\cl0Zet.bat")

```
Vous lancer le ".bat".


## Root

  https://www.houseofbim.com/posts/son-of-a-batch-autocad-core-console-through-lisp/

  https://through-the-interface.typepad.com/through_the_interface/2012/02/the-autocad-2013-core-console.html
  