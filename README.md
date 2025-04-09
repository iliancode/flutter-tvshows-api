# 📺 Application Flutter - TV Shows

Une application mobile Flutter permettant de découvrir des séries TV populaires, rechercher des séries, et consulter leurs détails. Les données sont récupérées dynamiquement depuis l'API publique de [Episodate](https://www.episodate.com/).

---

## 🚀 Fonctionnalités principales

- 🔥 Liste des séries TV populaires
- 🔎 Barre de recherche pour trouver des séries
- 📄 Affichage des détails d'une série (image, nom, description)
- 🔁 Chargement infini ("infinite scroll") des résultats
- ⚡ Navigation entre les écrans

---

## 🛠️ Technologies utilisées

- **Flutter** : Framework mobile principal
- **HTTP** : Pour les requêtes API REST
- **Provider** & **ChangeNotifier** : Gestion d'état globale
- **API Episodate** :
    - `https://www.episodate.com/api/most-popular?page=:page`
    - `https://www.episodate.com/api/search?q=:name&page=:page`
    - `https://www.episodate.com/api/show-details?q=:id`

---

## 📦 Installation du projet

### 1. Prérequis
- Flutter installé : [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
- Un IDE comme VS Code ou Android Studio

### 2. Cloner le projet
```bash
git clone https://github.com/votre-utilisateur/tv_shows_app.git
cd tv_shows_app
