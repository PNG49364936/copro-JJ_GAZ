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
| date_facture | date | Date de la facture (obligatoire) |
| periode_debut | date | Début de la période de consommation |
| periode_fin | date | Fin de la période de consommation |
| index_precedent | decimal | Index du compteur au début |
| index_actuel | decimal | Index du compteur à la fin |
| consommation_m3 | decimal | Consommation en m³ (calculé automatiquement) |
| montant_ht | decimal | Montant hors taxes |
| montant_ttc | decimal | Montant TTC (obligatoire) |
| prix_unitaire_m3 | decimal | Prix unitaire €/m³ (calculé automatiquement) |
| notes | text | Notes ou commentaires |

## Fonctionnalités
- CRUD complet des factures
- Calcul automatique de la consommation (index actuel - index précédent)
- Calcul automatique du prix unitaire (montant TTC / consommation)
- Tableau de bord avec totaux et moyenne
- Interface entièrement en français

## Commandes utiles

```bash
# Démarrer le serveur
cd /Users/pierrenoelgauthier/documents/png/gaz_manager
bin/rails server

# Console Rails
bin/rails console

# Migrations
bin/rails db:migrate
```

## Instructions pour Claude

Ajoutez vos instructions personnalisées ici...
