Mon Nom : Fatou Bintou BARRO

Nom du binôme : Fatoumata CAMARA


# 🌦️ Météo App – LIAGE/ISI KM 2025

Application mobile Flutter développée dans le cadre de l’examen de **Développement Mobile LIAGE/ISI KM 2025**.  
Elle permet de consulter la météo en temps réel pour plusieurs villes, avec une jauge animée, un affichage sur carte et un mode sombre/clair.  

---

##  Fonctionnalités

-  **Écran d’accueil** : message d’introduction et bouton "Commencer".  
-  **Écran principal** :  
  - Jauge de progression animée  
  - Messages dynamiques d’attente  
  - Appels API météo (OpenWeather) pour 5 villes (Dakar, Paris, New York, Tokyo, Berlin)  
  - Tableau interactif affichant température et conditions météo  
- **Interactions avancées** :  
  - Détails météo complets (température, humidité, vent, pression)  
  - Localisation sur carte **OpenStreetMap** (sans clé API, marche Web/Android/iOS)  
  - Gestion des erreurs API avec bouton "Réessayer"  
  - Mode **sombre/clair** automatique + switch manuel (🌞/🌙)  
-  **Navigation & rejouabilité** :  
  - Bouton "Recommencer" pour relancer l’expérience  
  - Retour simple vers l’accueil  

---

##  Technologies utilisées

- [Flutter](https://flutter.dev) – Framework mobile multiplateforme  
- [Dio](https://pub.dev/packages/dio) – Appels HTTP vers OpenWeather  
- [Provider](https://pub.dev/packages/provider) – Gestion du thème clair/sombre  
- [Flutter Map](https://pub.dev/packages/flutter_map) – Carte interactive OpenStreetMap  
- [Percent Indicator](https://pub.dev/packages/percent_indicator) – Jauge de progression animée  


