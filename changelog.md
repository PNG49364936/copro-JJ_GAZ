05/02/2026_1
il va fallor rajouter une periode 2023/2024 dans le fichier "tableau_comparaison.html.erb

La période 2023/2024 sera ajoutée avant 2024/2025.
Suite non disponibilité des consommations et couts pour l annéé 2023/2024, 
toutes les colonnes de octobre à avril seront grisées car pas de données à rentrer.
La colonne TOTAL sera renseignée avec les éléments suivants :
Volume = 7396. Vol HT = 3370. Total TTC = 8512
m3 HT	m3 TTC seront calculés par l'app.
Ces données doivent être stockées dans la BD car seront utilisées au même titre que les mêmes données des 2024/2025 et 2025/2026.
Se limiter dans un premier temps à ces modifications.

05/02/2026_2
Dans tableau_comparaison.html.erb, il y a :
<div class="row">
    <div class="col-md-4">
      <div class="card border-danger">
        <div class="card-body text-center">
          <h6>Évolution Volume</h6>
          <p class="display-6 text-danger">
            +45,4%
          </p>
          <small class="text-muted">
            536 m³
          </small>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card border-danger">
        <div class="card-body text-center">
          <h6>Évolution Total TTC</h6>
          <p class="display-6 text-danger">
            +39,4%
          </p>
          <small class="text-muted">
            868 €
          </small>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card border-success">
        <div class="card-body text-center">
          <h6>Évolution €/m³ TTC</h6>
          <p class="display-6 text-success">
            -4,1%
          </p>
          <small class="text-muted">
            -0,08 €/m³
          </small>
        </div>
      </div>
    </div>

    05/02/2026_3
    Dans tableau_comparaison.html.erb, sélection des périodes à comparer.

Modification à apporter dans les menus déroulants :
Pour rappel, pour 2023/2024, il n'existe pas de données mensuelles mais seulement annuelles donc :
- periode 1 doit être en gris clair(à l identique du font mois debut) et non sélectionnable.
- période 2 doit être en gris clair(à l identique du font mois debut) et non sélectionnable.