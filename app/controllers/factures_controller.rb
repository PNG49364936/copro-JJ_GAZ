class FacturesController < ApplicationController
  before_action :set_facture, only: [:show, :edit, :update, :destroy]

  def index
    @factures = Facture.par_date
    @periodes_budgetaires = Facture::PERIODES_BUDGETAIRES
    @totaux_par_periode = {}

    Facture::PERIODES_BUDGETAIRES.each do |nom, code|
      factures = Facture.where(periode_budgetaire: code)

      # Les sommes fonctionnent aussi pour les périodes "total only"
      # car elles n'ont qu'une seule facture avec les totaux
      volume = factures.sum(:consommation_m3)
      vol_ht = factures.sum(:montant_ht)
      total_ttc = factures.sum(:montant_ttc)

      @totaux_par_periode[code] = {
        nom: nom,
        volume: volume,
        vol_ht: vol_ht,
        total_ttc: total_ttc,
        m3_ht: volume > 0 ? vol_ht / volume : 0,
        m3_ttc: volume > 0 ? total_ttc / volume : 0
      }
    end
  end

  def show
  end

  def new
    @facture = Facture.new
  end

  def create
    @facture = Facture.new(facture_params)
    if @facture.save
      redirect_to factures_path, notice: "Facture créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @facture.update(facture_params)
      redirect_to factures_path, notice: "Facture mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @facture.destroy
    redirect_to factures_path, notice: "Facture supprimée."
  end

  def tableau_couts
    @periodes_budgetaires = Facture::PERIODES_BUDGETAIRES
    @mois = Facture::PERIODES
    @factures_par_periode = {}
    @periodes_total_only = {}

    Facture::PERIODES_BUDGETAIRES.each do |nom, code|
      @factures_par_periode[code] = {}
      factures = Facture.where(periode_budgetaire: code)

      # Vérifier si c'est une période "total only" (n'a qu'une facture avec période "total")
      facture_total = factures.find_by(periode: "total")
      if facture_total && factures.count == 1
        @periodes_total_only[code] = facture_total
      end

      factures.each do |f|
        @factures_par_periode[code][f.periode] = f
      end
    end
  end

  def tableau_comparaison
    @mois_comparaison = Facture::PERIODES.reject { |_, code| code == "septembre" || code == "mai" || code == "total" }
    @periodes_budgetaires = Facture::PERIODES_BUDGETAIRES

    # Construire la map des données disponibles par période
    @donnees_disponibles = {}
    @periodes_total_only = {}

    Facture::PERIODES_BUDGETAIRES.each do |nom, code|
      factures = Facture.where(periode_budgetaire: code)
      facture_total = factures.find_by(periode: "total")
      is_total_only = facture_total && factures.count == 1

      if is_total_only
        @periodes_total_only[code] = facture_total
      end

      @donnees_disponibles[code] = {
        nom: nom,
        has_octobre: Facture.exists?(periode_budgetaire: code, periode: "octobre"),
        is_total_only: is_total_only,
        mois_disponibles: []
      }

      @mois_comparaison.each do |mois_nom, mois_code|
        if Facture.exists?(periode_budgetaire: code, periode: mois_code)
          @donnees_disponibles[code][:mois_disponibles] << mois_code
        end
      end
    end

    # Périodes comparables (ont au moins octobre OU sont "total only")
    @periodes_comparables = @donnees_disponibles.select { |_, v| v[:has_octobre] || v[:is_total_only] }

    # Récupérer les factures pour la comparaison
    @factures_par_periode = {}
    Facture::PERIODES_BUDGETAIRES.each do |nom, code|
      @factures_par_periode[code] = {}
      Facture.where(periode_budgetaire: code).each do |f|
        @factures_par_periode[code][f.periode] = f
      end
    end

    # Paramètres de comparaison
    @periode1 = params[:periode1]
    @periode2 = params[:periode2]
    @mois_debut = params[:mois_debut]
    @mois_fin = params[:mois_fin]

    # Calcul des résultats si paramètres présents
    if @periode1.present? && @periode2.present? && @mois_debut.present? && @mois_fin.present?
      @resultats = calculer_comparaison(@periode1, @periode2, @mois_debut, @mois_fin)
    end
  end

  private

  def calculer_comparaison(periode1, periode2, mois_debut, mois_fin)
    mois_ordre = %w[octobre novembre decembre janvier fevrier mars avril]
    idx_debut = mois_ordre.index(mois_debut)
    idx_fin = mois_ordre.index(mois_fin)
    return nil if idx_debut.nil? || idx_fin.nil? || idx_debut > idx_fin

    mois_range = mois_ordre[idx_debut..idx_fin]

    resultats = { periode1: { nom: "", mois: {}, totaux: {}, is_total_only: false }, periode2: { nom: "", mois: {}, totaux: {}, is_total_only: false } }

    [periode1, periode2].each_with_index do |periode, idx|
      key = idx == 0 ? :periode1 : :periode2
      resultats[key][:nom] = Facture::PERIODES_BUDGETAIRES.find { |_, c| c == periode }&.first || periode

      # Vérifier si c'est une période "total only"
      facture_total = Facture.find_by(periode_budgetaire: periode, periode: "total")
      factures = Facture.where(periode_budgetaire: periode)
      is_total_only = facture_total && factures.count == 1

      resultats[key][:is_total_only] = is_total_only

      total_volume = 0
      total_ht = 0
      total_ttc = 0

      if is_total_only
        # Période avec totaux uniquement - utiliser directement la facture "total"
        total_volume = facture_total.consommation_m3 || 0
        total_ht = facture_total.montant_ht || 0
        total_ttc = facture_total.montant_ttc || 0
        # Pas de données mensuelles
      else
        # Période normale - calculer à partir des factures mensuelles
        mois_range.each do |mois|
          facture = Facture.find_by(periode_budgetaire: periode, periode: mois)
          if facture
            resultats[key][:mois][mois] = {
              volume: facture.consommation_m3,
              vol_ht: facture.montant_ht,
              total_ttc: facture.montant_ttc,
              m3_ht: facture.consommation_m3 > 0 ? facture.montant_ht / facture.consommation_m3 : 0,
              m3_ttc: facture.consommation_m3 > 0 ? facture.montant_ttc / facture.consommation_m3 : 0
            }
            total_volume += facture.consommation_m3 || 0
            total_ht += facture.montant_ht || 0
            total_ttc += facture.montant_ttc || 0
          end
        end
      end

      resultats[key][:totaux] = {
        volume: total_volume,
        vol_ht: total_ht,
        total_ttc: total_ttc,
        m3_ht: total_volume > 0 ? total_ht / total_volume : 0,
        m3_ttc: total_volume > 0 ? total_ttc / total_volume : 0
      }
    end

    # Calcul des écarts
    resultats[:ecarts] = {
      volume: resultats[:periode2][:totaux][:volume] - resultats[:periode1][:totaux][:volume],
      vol_ht: resultats[:periode2][:totaux][:vol_ht] - resultats[:periode1][:totaux][:vol_ht],
      total_ttc: resultats[:periode2][:totaux][:total_ttc] - resultats[:periode1][:totaux][:total_ttc],
      m3_ht: resultats[:periode2][:totaux][:m3_ht] - resultats[:periode1][:totaux][:m3_ht],
      m3_ttc: resultats[:periode2][:totaux][:m3_ttc] - resultats[:periode1][:totaux][:m3_ttc]
    }

    # Pourcentages d'évolution
    resultats[:evolution] = {}
    [:volume, :vol_ht, :total_ttc, :m3_ht, :m3_ttc].each do |key|
      base = resultats[:periode1][:totaux][key]
      resultats[:evolution][key] = base != 0 ? ((resultats[:ecarts][key] / base) * 100) : 0
    end

    resultats[:mois_range] = mois_range
    resultats
  end

  def set_facture
    @facture = Facture.find(params[:id])
  end

  def facture_params
    params.require(:facture).permit(
      :periode, :periode_budgetaire, :consommation_m3,
      :montant_ht, :montant_ttc, :notes
    )
  end
end
