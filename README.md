# ACCORE
Depuis le version 2013, AutoCAD dispose d'une version de ligne de commande d'AutoCAD qui peut vous aider à accélérer considérablement le traitement par lots des dessins.

Dans le dossier d'installation d'AutoCAD, vous pouvez trouver le "AccoreConsole.exe". 

Copier/Coller ceci dans la barre de commande Autocad :

(findfile "accoreconsole.exe")

vous retourne le chemin d'accoreconsole.exe

"C:\\Program Files\\Autodesk\\AutoCAD 2015\\accoreconsole.exe"

Ici pour une 2015.

Le simple fait de l'exécuter affichera les commutateurs de ligne de commande qui peuvent être utilisés avec lui.

![](./img/illu1.png)

Il accepte quatre commutateurs de ligne de commande :

1) /i : utilisé pour spécifier le chemin du fichier de dessin sur lequel exécuter le fichier de script

2) /s : utilisé pour spécifier le chemin d'accès au fichier de script.

3) /l : Si des packs de langue sont installés, vous avez le choix d'invoquer la version linguistique d'accoreconsole. Les commandes du fichier de script peuvent alors être dans l'une des langues que vous avez installées sur votre système.(optionel)

4) /isolate : utilisé pour empêcher les modifications apportées aux variables système d'affecter AutoCAD normal.(optionel)






### Root

  https://www.houseofbim.com/posts/son-of-a-batch-autocad-core-console-through-lisp/
  