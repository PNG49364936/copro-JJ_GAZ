# Gestion Gaz - SDC Jean Jaurès

## Description
Application Rails de gestion des coûts de consommation de gaz avec calcul du coût unitaire en m³.

## Technologies
- Rails 7.1.6
- Ruby 3.2.2
- SQLite3 (base de données locale)
- Bootstrap 5 (via cssbundling-rails)

## Modèle de données

### Facture
| Champ | Type | Description |
|-------|------|-------------|
| periode_budgetaire | string | Période budgétaire (2024_2025, 2025_2026, 2026_2027) |
| periode | string | Mois (octobre à avril) |
| consommation_m3 | decimal | Volume en m³ |
| montant_ht | decimal | Conso HT (€) |
| montant_ttc | decimal | Facture TTC (€) |
| prix_unitaire_m3 | decimal | Prix unitaire €/m³ (calculé automatiquement) |
| notes | text | Notes ou commentaires |

### Périodes budgétaires disponibles
- 2023/2024 (totaux annuels uniquement)
- 2024/2025
- 2025/2026
- 2026/2027

### Mois disponibles
- Total annuel (pour périodes sans détail mensuel)
- Octobre, Novembre, Décembre, Janvier, Février, Mars, Avril

## Pages de l'application

### Page d'accueil (/)
- Cards par période budgétaire
- Pour chaque période : Volume, Total TTC, m³ HT, m³ TTC
- **Période 2023/2024** : Volume et Total TTC floutés (blur) car données directes non calculées

### Tableau des coûts (/tableau_couts)
- Tableau type Excel avec colonnes par mois (Oct à Avr)
- Pour chaque mois : Volume, Vol HT, Total TTC, m³ HT, m³ TTC
- Colonne Total avec sommes et moyennes

### Comparaison des périodes (/tableau_comparaison)
- Comparaison de deux périodes budgétaires
- Sélection des mois de début et fin (plage de comparaison)
- **Période 2023/2024** : non sélectionnable (grisée, disabled) car pas de données mensuelles
- Tableau compact avec données par mois : Vol, HT, TTC, €m3/HT, €m3TTC
- Ligne Écart : différences entre périodes
- Ligne % : évolution en pourcentage
- Colonne TOT : totaux de la plage sélectionnée
- **4 Cards résumé** : Évolution Volume, Total TTC, €/m³ HT, €/m³ TTC
- Couleurs : vert (baisse), rouge (hausse)
- Filtrage dynamique : seuls les mois avec données pour les deux périodes sont comparables

### Formulaire nouvelle facture (/factures/new)
- Sélection période budgétaire
- Sélection mois
- Saisie : Volume m³, Conso HT, Facture TTC
- Notes optionnelles

## Calculs automatiques
- **m³ HT** = Vol HT / Volume
- **m³ TTC** = Total TTC / Volume
- **Prix unitaire** = Montant TTC / Consommation

## Gestion des périodes "Total uniquement"

Certaines périodes budgétaires (comme 2023/2024) n'ont pas de données mensuelles disponibles, seulement des totaux annuels.

### Caractéristiques
- Une seule facture avec la période "total"
- Colonnes mensuelles grisées dans les tableaux
- Colonne TOTAL renseignée avec les valeurs annuelles
- Calculs m³ HT et m³ TTC effectués automatiquement
- Comparaison possible avec d'autres périodes (sur les totaux uniquement)

### Affichage
- **Tableau des coûts** : colonnes Oct-Avr grisées (bg-secondary bg-opacity-10)
- **Comparaison** :
  - Colonnes mensuelles grisées, seuls les totaux sont comparables
  - Période 2023/2024 non sélectionnable dans les dropdowns (disabled, gris clair)
- **Page d'accueil** :
  - Volume et Total TTC floutés (filter:blur(5px))
  - m³ HT et m³ TTC affichés normalement (valeurs calculées)

## Données actuelles
- **2023/2024** : Totaux annuels uniquement (1 facture) - 7396 m³, 3370 € HT, 8512 € TTC
- **2024/2025** : Oct à Avr (7 factures) - 34766 m³, 53447 € TTC
- **2025/2026** : Oct à Déc (3 factures) - 12551 m³, 19361 € TTC
- **2026/2027** : Aucune donnée

## Commandes utiles

```bash
# Démarrer le serveur
cd /Users/pierrenoelgauthier/documents/png/gaz_manager
bin/rails server

# Console Rails
bin/rails console

# Recharger les données
bin/rails db:seed

# Migrations
bin/rails db:migrate
```

## Structure des fichiers principaux
- `app/views/factures/index.html.erb` - Page d'accueil
- `app/views/factures/tableau_couts.html.erb` - Tableau Excel
- `app/views/factures/tableau_comparaison.html.erb` - Page de comparaison
- `app/views/factures/_form.html.erb` - Formulaire de saisie
- `app/controllers/factures_controller.rb` - Contrôleur
- `app/models/facture.rb` - Modèle avec validations
- `db/seeds.rb` - Données initiales

## Instructions pour Claude

- Ne pas demander de validation lors des modifications de code
- Conserver le style Bootstrap 5
- Interface uniquement en français
- Calculs m³ HT et m³ TTC basés sur les formules ci-dessus
