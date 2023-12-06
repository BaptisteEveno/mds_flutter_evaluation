# Projet Flutter - Clicker Game et Projet Démo

## Installation

1. Clonez ce dépôt sur votre machine locale 
2. Checker que la dependencies "Provider" est bien installé. Si non faites dans votre terminal
```bash
flutter pub add provider  
```


## Clicker Game

### Description

Le projet "Clicker Game" est un jeu simple basé sur le principe du "clicker", où l'utilisateur doit cliquer sur un élément à l'écran pour gagner des ressources. Le jeu dispose d'un système de ressources, d'un inventaire, et de recettes à débloquer. Le but est de collecter autant de ressources que possible en cliquant rapidement.
Puis de fabriquer les recettes dans la page recettes que vous pourrez retrouver dans la page inventaire.

### Fonctionnalités

- Mécanique de clic pour collecter des ressources.
- Système de ressources comprenant le bois, le minerai de fer, le minerai de cuivre et le charbon.
- Système de Provider pour importer les ressources de la page "Ressource" à la page "Recette"
- Il est possible d'ajouter très facilement des recettes grâce au fichier recipes.json situer dans le fichier assets.
- Possibilité de débloquer des recettes en collectant suffisamment de ressources. Grâce au Provider vous pourrez les retrouvez dans la page Inventaire.

### Lancer l'application

Dans le terminal de votre projet :
1.
```bash 
cd lib\cliquer_game
```
2.
```bash 
flutter run main.dart
```

 
## Projet Mémo Widget Gesture
### Description

J'ai décider d'utiliser et de tester le widget Gesture qui un qui permet de détecter et de réagir aux gestes de l'utilisateur, tels que les appuis, les balayages, les pincements, etc. Il encapsule un ou plusieurs autres widgets et fournit des gestionnaires d'événements pour différents types de gestes. Lorsqu'un geste est détecté à l'intérieur d'un GestureDetector, vous pouvez déclencher des actions spécifiques en réponse à ce geste, ce qui permet d'ajouter une interactivité tactile à votre application Flutter.
Lorsque vous balayerais a gauche vous aurez un message et inversemement.

### Lancer l'application

Dans le terminal de votre projet :
1.
```bash 
cd lib\veille_flutter
```
2.
```bash 
flutter run widgets_gesture.dart
```
