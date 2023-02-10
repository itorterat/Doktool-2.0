# Doktool-2.0

Doktool-2.0 est un outil pour Dofus 2, pour se faciliter la vie en multi-compte, écrit en AutoHotKey v2.  
Le but de cet outil est d'intégrer des fonctionnalités améliorant l'ergonomie du jeu en multi-compte, qui selon moi, devraient être intégrées de base dans le jeu (Cf. [Système de Héros dans Wakfu](https://www.wakfu.com/fr/mmorpg/actualites/devblog/billets/436459-systeme-heros)).

## Fonctionnalités

Sa version actuelle permet de :

- **ERGONOMIE:** Utiliser un raccourci clavier associé à la fenêtre d'un personnage (`Alt+A, Alt+Z, Alt+E, Alt+R, Alt+Q, Alt+S, Alt+D, Alt+F`) pour naviguer de fenêtre en fenêtre (plus précis que `Alt+Echap` ou `Alt+Tab`),
- **ERGONOMIE:** Utiliser un raccourci clavier (`Thumb Mouse Button 1`) pour effectuer un clic gauche sur tous les personnages, là où le curseur de la souris se situe (_possibilité de déplacement, parler à un PNJ, interagir avec un objet, ..._),
- **ERGONOMIE:** Utiliser un raccourci clavier (`F2`) pour cliquer à une position définie sur tous les personnages (_clic sur les notifications d'invitation de groupe, rejoindre un combat, ..._)
- **DÉPLACEMENT:** Déplacer ses personnages de carte en carte grâce aux flèches du clavier,
- **COMBAT:** Permet de basculer automatiquement vers la fenêtre dont le personnage doit jouer son tour lors d'un combat.

## Installation

- Afin de pouvoir utiliser Doktool-2.0, il est nécessaire de [télécharger et installer **AutoHotKey V2**](https://www.autohotkey.com/download/).
- Télécharger le contenu du répo de Doktool-2.0.
- Vérifier / compléter les paramètres et images nécessaires (voir Section `Prérequis`) plus bas.

## Prérequis

**ATTENTION : Les fichiers et dossiers du répertoire sont nommés d'une certaine façon à ce que le script puisse accéder à ceux-ci. En cas de modification d'un nom de fichier, ou d'un nom de dossier, il sera nécessaire de modifier les lignes correspondantes dans le script.**

#### Coordonnées

La plupart des fonctionnalités utilisent des coordonnées (X,Y) pour effectuer une action dessus (clic, recherche d'image).

Pour récupérer ces coordonnées (X,Y), vous pouvez utiliser l'outil `AutoHotkey Window Spy` (installé automatiquement lors de l'installation de AutoHotKey) :

- ouvrir l'outil `AutoHotkey Window Spy`,
- cliquer sur la fenêtre Dofus à analyser (pour qu'elle ait le focus),
- positionner le curseur de la souris sur la position à récupérer,
- lire et noter la position indiquée dans l'outil, à la ligne `Client` de la rubrique `Mouse` (exemple : `Client : 375, 275`, les coordonnées seront donc `X=375` et `Y=275`).

Ces coordonnées doivent être renseignées dans le fichier `settings2.0.txt` situé dans le dossier `resources/`.  
Les coordonnées peuvent prendre 2 formes :

- Un paramètre avec un couple de coordonnées (X,Y)

> notifX:375  
> notifY:275

- Un paramètre avec deux couples de coordonnées (X1,Y1,X2,Y2), où (X1,Y1) correspond au pixel en haut à gauche de la zone à rechercher, et où (X2,Y2) correspond au pixel en bas à droite de la zone à rechercher

> buttonGiveUpX1:1930  
> buttonGiveUpY1:1330  
> buttonGiveUpX2:1980  
> buttonGiveUpY2:1380

#### Images

Le script utilise des images afin de faire de la reconnaissance d'image.  
Les images nécessaires au bon fonctionnement du script sont :

- `GiveUp.png` (dans le dossier `resources/`) : permet de détecter si le personnage est actuellement en combat,

Vous devez prendre une capture d'écran lors d'un combat, puis rogner l'image pour conserver uniquement la croix qui permet d'abandonner un combat.

- `NomDuPersonnage.png` (dans le dossier `resources/characters/`) : permet de détecter le personnage qui doit jouer son tour.

Vous devez prendre une capture d'écran de l'illustration du début de tour du personnage, rogner l'image pour obtenir uniquement le nom du personnage.

Le nom du fichier d'une image d'un personnage doit être **EXACTEMENT** le même que le nom réel du personnage, avec les minscules et majuscules exactes.

> Le personnage s'appelle "Doktool", le fichier devra se nommer "Doktool.png".  
> Le personnage s'appelle "suPER-doKtool", le fichier devra se nommer "suPER-doKtool.png"

Un exemple est disponible actuellement dans le dossier `resources/characters/`, avec le personnage "Okto-Dawa".

#### Liste des paramètres

- `buttonGiveUpX1` : coordonnée **X**, en haut à gauche de la zone de recherche de la croix pour abandonner
- `buttonGiveUpY1` : coordonnée **Y**, en haut à gauche de la zone de recherche de la croix pour abandonner
- `buttonGiveUpX2` : coordonnée **X**, en bas à droite de la zone de recherche de la croix pour abandonner
- `buttonGiveUpY2` : coordonnée **Y**, en bas à droite de la zone de recherche de la croix pour abandonner
- `illustrationStartTurnX1` : coordonnée **X**, en haut à gauche de la zone de recherche de l'illustration du début de tour d'un personnage
- `illustrationStartTurnY1` : coordonnée **Y**, en haut à gauche de la zone de recherche de l'illustration du début de tour d'un personnage
- `illustrationStartTurnX2` : coordonnée **X**, en bas à droite de la zone de recherche de l'illustration du début de tour d'un personnage
- `illustrationStartTurnY2` : coordonnée **Y**, en bas à droite de la zone de recherche de l'illustration du début de tour d'un personnage
- `notifX` : coordonnée **X**, du bouton à cliquer de la notification (rejoindre un groupe, rejoindre un combat,....)
- `notifY` : coordonnée **Y**, du bouton à cliquer de la notification (rejoindre un groupe, rejoindre un combat,....)
- `topMapX` : coordonnée **X**, de l'endroit à cliquer en haut de l'écran pour changer de carte
- `topMapY` : coordonnée **Y**, de l'endroit à cliquer en haut de l'écran pour changer de carte
- `bottomMapX` : coordonnée **X**, de l'endroit à cliquer en bas de l'écran pour changer de carte
- `bottomMapY` : coordonnée **Y**, de l'endroit à cliquer en bas de l'écran pour changer de carte
- `leftMapX` : coordonnée **X**, de l'endroit à cliquer à gauche de l'écran pour changer de carte
- `leftMapY` : coordonnée **Y**, de l'endroit à cliquer à gauche de l'écran pour changer de carte
- `rightMapX` : coordonnée **X**, de l'endroit à cliquer à droite de l'écran pour changer de carte
- `rightMapY` : coordonnée **Y**, de l'endroit à cliquer à droite de l'écran pour changer de carte

**ATTENTION : Actuellement les valeurs renseignées dans les settings et les images utilisées sont celles que j'utilise. Mon jeu utilise le thème de base, mes fenêtres sont en plein écran fenêtré, et ma résolution est 2560\*1440. Ces valeurs pourraient donc fonctionner pour vous, mais il est hautement recommander d'utiliser vos propres valeurs, et surtout, vos propres images (notamment des noms de vos personnages).**

## Utilisation

0. (Les prérequis doivent être remplis au moins une fois avant de pouvoir lancer le script)
1. Connecter ses comptes, puis ses personnages
2. Lancer le script

Vous pourrez ensuite utiliser les raccourcis `Alt+A, Alt+Z, Alt+E, Alt+R, Alt+Q, Alt+S, Alt+D, Alt+F` pour naviguer entre vos fenêtres Dofus, déplacer vos personnages de carte en carte avec les flèches de votre clavier, faire un clic sur toutes les fenêtres simultanément, ...  
Le bouton `Refresh` est présent pour pouvoir changer l'ordre d'initiative de vos personnages (ou l'ordre de défilement des fenêtres). Comme à la manière d'un `Alt+Echap`, le script enregistre les fenêtres selon leur ordre d'activation, donc la première fenêtre cliquée sera la dernière de la liste, et la dernière fenêtre cliquée sera la première de la liste...
