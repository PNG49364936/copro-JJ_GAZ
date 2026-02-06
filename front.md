# Frontend - Gestion Gaz

## Framework CSS
- **Bootstrap 5** via cssbundling-rails
- **Bootstrap Icons** pour les icônes

## Layout principal (`application.html.erb`)

### Navbar
- Fond bleu primaire (`bg-primary`)
- Logo avec icône fuel-pump + "Gestion Gaz"
- Boutons navigation à droite :
  - Tableau coûts
  - Comparaison
  - Nouvelle facture

### Alertes
- Success : `alert-success` (vert)
- Danger : `alert-danger` (rouge)
- Dismissible avec bouton fermer

### Footer
- Texte centré, bordure top, texte muted
- "SDC Jean Jaurès - Gestion des coûts de consommation gaz"

---

## Page d'accueil (`index.html.erb`)

### Structure
- Titre h1 : "Suivi des coûts de gaz"
- Cards Bootstrap pour chaque période budgétaire

### Cards par période
- Header bleu (`bg-primary`) avec nom période
- Body avec 4 métriques en grille 2x2 :
  - Volume (m³)
  - Total TTC (€)
  - m³ HT (€/m³)
  - m³ TTC (€/m³)
- Formatage nombres : `number_with_delimiter` et `number_with_precision`

---

## Tableau des coûts (`tableau_couts.html.erb`)

### Structure
- Card avec header vert (`bg-success`)
- Table responsive Bootstrap

### Tableau
- Classes : `table table-bordered table-hover table-sm`
- Header sombre (`table-dark`)
- Colonnes par mois (Oct à Avr) + Total
- 5 métriques par mois : Volume, Vol HT, Total TTC, m³ HT, m³ TTC

### Lignes
- Une ligne par période budgétaire
- Première colonne : nom période (fond `table-light`)
- Données alignées à droite (`text-end`)
- Colonne Total en gras (`fw-bold`, fond `table-primary`)

### Cellules vides
- Colspan 5 avec tiret centré et texte muted

---

## Page de comparaison (`tableau_comparaison.html.erb`)

### Formulaire de sélection
- Card avec header bleu
- 4 champs en ligne (row Bootstrap) :
  - Période 1 (référence) - select
  - Période 2 (comparée) - select
  - Mois début - select
  - Mois fin - select
- Bouton "Comparer" (`btn-primary`)

### Tableau de comparaison
- Style compact personnalisé :
  ```css
  .table-compact { font-size: 0.75rem; }
  .table-compact th, .table-compact td {
    padding: 0.2rem 0.3rem;
    white-space: nowrap;
  }
  ```

### En-têtes tableau
- Mois abrégés : Oct, Nov, Déc, Jan, Fév, Mar, Avr
- Colonnes : Vol, HT, TTC, €HT, €TTC
- Colonne TOT pour les totaux

### Lignes de données
- Période 1 et 2 : données brutes
- Écart : différences (fond `table-warning`)
- % : pourcentages d'évolution (fond `table-info`)

### Code couleur
- **Hausse** : `text-danger` (rouge) - défavorable
- **Baisse** : `text-success` (vert) - favorable
- Préfixe "+" pour les hausses

### Cards résumé visuel
- 3 cards en row (col-md-4)
- Bordure colorée selon évolution (`border-danger` / `border-success`)
- Contenu centré :
  - Titre (h6)
  - Pourcentage en grand (`display-6`)
  - Valeur absolue en small muted

### JavaScript dynamique
- `updateMoisOptions()` : filtre les mois disponibles selon périodes sélectionnées
- `updateMoisFin()` : désactive les mois antérieurs au mois de début
- Mois non disponibles marqués avec "(-)" et désactivés

---

## Formulaire facture (`_form.html.erb`)

### Structure
- Card avec header "Données factures"
- Formulaire Rails avec `form_with`

### Champs
- **Période budgétaire** : select avec options du modèle
- **Mois** : select avec options du modèle
- **Volume m³** : input number avec step 0.01
- **Conso HT** : input number avec step 0.01
- **Facture TTC** : input number avec step 0.01
- **Notes** : textarea (3 rows)

### Validation
- Erreurs affichées dans `alert-danger`
- Liste des erreurs en ul/li

### Boutons
- Submit : "Enregistrer" (`btn-primary`)
- Annuler : lien vers index (`btn-secondary`)

---

## Conventions de style

### Classes Bootstrap utilisées
| Élément | Classes |
|---------|---------|
| Cards | `card`, `card-header`, `card-body` |
| Tables | `table`, `table-bordered`, `table-hover`, `table-sm`, `table-responsive` |
| Boutons | `btn`, `btn-primary`, `btn-outline-light`, `btn-secondary` |
| Formulaires | `form-select`, `form-control`, `form-label` |
| Grille | `row`, `col-md-*`, `container` |
| Texte | `text-end`, `text-center`, `text-muted`, `fw-bold` |
| Couleurs fond | `bg-primary`, `bg-success`, `table-dark`, `table-light`, `table-primary` |

### Formatage des nombres
- Volumes : entiers sans décimales
- Montants € : entiers sans décimales
- Prix unitaires (€/m³) : 2 décimales
- Pourcentages : entiers avec symbole %

### Responsive
- Tables avec `table-responsive` pour scroll horizontal
- Grille Bootstrap pour adaptation mobile
- Navbar avec `navbar-expand-lg`
