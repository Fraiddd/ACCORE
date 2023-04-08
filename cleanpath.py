# coding: utf-8
# Python 3.11.1
'''
cleanpath

Supprime les chemins en doubles dans la variable d'environnement PATH.

'''
import os
from collections import OrderedDict

# Récupère la valeur actuelle de la variable PATH
path = os.environ['PATH']

# Sépare les différents chemins dans une liste
path_list = path.split(';')

# Supprime les doublons tout en maintenant l'ordre initial
clean_path_list = list(OrderedDict.fromkeys(path_list))

# Rejoint les chemins pour recréer la variable PATH nettoyée
clean_path = ';'.join(clean_path_list)

# Définit la nouvelle valeur de la variable PATH
os.environ['PATH'] = clean_path

print("La variable PATH a été nettoyée.")
