# Mali Tonsigui — code source Flutter

Prototype fonctionnel (données en mémoire, pas de backend) reprenant les 3 écrans
validés : tableau de bord, cycle en cours (tirage au sort), ajout de membre.

## Ce que fait déjà le code

- Navigation entre les 3 écrans par onglets
- Enregistrement du gagnant du tirage (fait en réunion, saisi dans l'appli)
- Marquer un membre comme "payé" pour le cycle en cours (appuyer sur "en attente")
- Ajout d'un membre par nom + téléphone
- Palette doré / corail / vert reprise du prototype visuel, logo aux couleurs
  du drapeau du Mali

Ce n'est pas encore branché à un vrai téléphone (mobile money, SMS, base de
données) — c'est la structure de l'appli, prête à recevoir ces briques.

## Comment obtenir l'APK

Je ne peux pas compiler l'APK moi-même (mon environnement n'a pas accès à
internet pour télécharger le SDK Flutter/Android). Voici comment le faire,
toi ou un développeur, une fois ce dossier récupéré :

### 1. Installer les outils (une seule fois)
- Installer Flutter : https://docs.flutter.dev/get-started/install
- Installer Android Studio (fournit le SDK Android)
- Vérifier l'installation : `flutter doctor`

### 2. Récupérer les dépendances
Depuis le dossier du projet :
```
flutter pub get
```

### 3. Tester en direct (optionnel mais recommandé)
Avec un téléphone Android branché en USB (mode développeur activé) ou un
émulateur :
```
flutter run
```

### 4. Générer l'APK
```
flutter build apk --release
```
Le fichier sera généré ici :
```
build/app/outputs/flutter-apk/app-release.apk
```
Il suffit ensuite de le transférer sur un téléphone Android (par câble,
Bluetooth, ou WhatsApp) et de l'installer directement (penser à autoriser
"sources inconnues" dans les paramètres Android si demandé).

## Prochaines étapes suggérées

- Persistance des données (aujourd'hui tout est réinitialisé à chaque
  lancement) — par exemple avec `shared_preferences` pour rester simple,
  ou une vraie base de données/backend si plusieurs téléphones doivent
  partager les mêmes tontines.
- Invitation réelle par SMS (aujourd'hui c'est simulé).
- Un mode hors-ligne robuste, vu le coût de la data au Mali.
