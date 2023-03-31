# ACCORE

Depuis le version 2013, AutoCAD dispose d'une version de ligne de commande d'AutoCAD qui peut vous aider à accélérer considérablement le traitement par lots des dessins en complément d'ObjectDBX.
Non supporté officiellement par Autodesk, il n'y a pas de documentation. 

## Principe d'utilisation
### Ligne de commande

Dans le dossier d'installation d'AutoCAD, vous pouvez trouver le "AccoreConsole.exe". 

Copier/Coller ceci dans la barre de commande Autocad :

(findfile "accoreconsole.exe")

vous retourne le chemin d'accoreconsole.exe

"C:\\Program Files\\Autodesk\\AutoCAD 2015\\accoreconsole.exe"

Ici pour une 2015.

Le simple fait de l'exécuter dans la console (cmd.exe), affichera les commutateurs de ligne de commande qui peuvent être utilisés avec lui, fait un test avec le dessin 8th_floor.dwg et le script test.scr et ouvre un session Autocad sur dessin1.dwg.

![](./img/illu1.png) 

Il accepte six commutateurs de ligne de commande :

1) /i : permet de spécifier le chemin du fichier de dessin sur lequel exécuter le fichier de script

2) /s : permet de spécifier le chemin d'accès au fichier de script.

3) /l : Si des packs de langue sont installés, vous avez le choix d'invoquer la version linguistique d'accoreconsole. Les commandes du fichier de script peuvent alors être dans l'une des langues que vous avez installées sur votre système.(optionnel, en/US par defaut)

4) /isolate : utilisé pour empêcher les modifications apportées aux variables système d'affecter AutoCAD normal.(optionnel)

5) /readonly : permet de spécifier que le fichier DWG doit être ouvert en lecture seule (optionnel, apparu avec la version 2015)

6) /p[rofile] permet de spécifier le nom d'un profil AutoCAD à utiliser lors de l'ouverture du fichier DWG. (optionnel, apparu avec la version 2015)








### Root

  https://www.houseofbim.com/posts/son-of-a-batch-autocad-core-console-through-lisp/
  