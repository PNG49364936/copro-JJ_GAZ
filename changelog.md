# Changelog - Gestion Gaz SDC Jean Jaurès

## 07/02/2026

### 07/02/2026_6 - Toutes périodes visibles dans dropdown Années
- 2025/2026 et 2026/2027 affichées mais grisées (disabled)
- Indication du nombre de mois renseignés : "(3/7 mois)", "(0/7 mois)"
- Sélectionnable uniquement si 7 mois complets OU "Total only"
- Message info : "Périodes grisées : mois incomplets (7/7 requis)"
- Fichiers : `factures_controller.rb`, `tableau_comparaison.html.erb`

### 07/02/2026_5 - Exception 2023/2024 dans comparaison
- Si 2023/2024 sélectionné : masquer Vol, HT, TTC (données non comparables)
- Tableau : affiche seulement €m3/HT et €m3/TTC
- Cards : affiche seulement Évolution €/m³ HT et €/m³ TTC (2 cards)
- Raison : 2023/2024 alimenté différemment (total annuel seul)
- Fichier : `tableau_comparaison.html.erb`

### 07/02/2026_4 - Double mode de comparaison
- Ajout mode "Années complètes à comparer" (formulaire vert)
- Sélectionnable si : 7 mois complets (Oct-Avr) OU période "Total only"
- Années disponibles : 2023/2024 (Total), 2024/2025 (7 mois)
- Années NON disponibles : 2025/2026 (3 mois), 2026/2027 (aucune donnée)
- Mode existant renommé "Périodes personnalisées" (formulaire bleu)
- Validation JS pour éviter comparaison années identiques
- Calculs inchangés (utilise octobre à avril automatiquement)
- Fichiers modifiés :
  - `factures_controller.rb` : @periodes_annees_completes, mode_comparaison
  - `tableau_comparaison.html.erb` : 2 formulaires côte à côte

### 07/02/2026_3 - Alerte périodes identiques
- Ajout validation JavaScript si Période 1 = Période 2
- Message : "Attention vous comparez les mêmes périodes"
- Fichier : `tableau_comparaison.html.erb`

### 07/02/2026_2 - 5 Cards résumé
- Ajout card "Évolution Total € HT" entre Volume et Total TTC
- Disposition en une seule ligne horizontale (row-cols-lg-5)
- Ordre : Volume m3, Total € HT, Total € TTC, €/m³ HT, €/m³ TTC
- Fichier : `tableau_comparaison.html.erb`

### 07/02/2026_1 - Correction tableau_couts
- Suppression colonne "Total Annuel" au début du tableau
- Alignement correct des 7 colonnes mensuelles (Oct à Avr)
- Colonne TOTAL en fin de tableau uniquement
- Fichier : `tableau_couts.html.erb`

---

## 06/02/2026

### 06/02/2026_1 - Blur page d'accueil
- Volume et Total TTC floutés pour période 2023/2024
- Style : `filter:blur(5px)`
- Raison : données renseignées directement, non calculées
- Fichier : `index.html.erb`

---

## 05/02/2026

### 05/02/2026_3 - Période 2023/2024 non sélectionnable
- Dropdowns Période 1 et Période 2 : option disabled
- Style gris clair : `background-color:#f8f9fa;color:#6c757d`
- Raison : pas de données mensuelles pour comparaison
- Fichier : `tableau_comparaison.html.erb`

### 05/02/2026_2 - Ajout card Évolution €/m³ HT
- Nouvelle card "Évolution €/m³ HT" dans le résumé visuel
- Position : après Total TTC, avant €/m³ TTC
- Fichier : `tableau_comparaison.html.erb`

### 05/02/2026_1 - Ajout période 2023/2024
- Nouvelle période budgétaire avant 2024/2025
- Données annuelles uniquement : 7396 m³, 3370 € HT, 8512 € TTC
- Colonnes mensuelles (Oct-Avr) grisées
- Période "total" ajoutée dans le modèle
- Fichiers modifiés :
  - `facture.rb` : PERIODES_BUDGETAIRES + PERIODES
  - `seeds.rb` : données 2023/2024
  - `factures_controller.rb` : gestion périodes "total only"
  - `tableau_couts.html.erb` : affichage grisé
  - `tableau_comparaison.html.erb` : gestion comparaison
