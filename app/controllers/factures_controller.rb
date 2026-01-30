class FacturesController < ApplicationController
  before_action :set_facture, only: [:show, :edit, :update, :destroy]

  def index
    @factures = Facture.par_date
    @periodes_budgetaires = Facture::PERIODES_BUDGETAIRES
    @totaux_par_periode = {}

    Facture::PERIODES_BUDGETAIRES.each do |nom, code|
      factures = Facture.where(periode_budgetaire: code)
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

    Facture::PERIODES_BUDGETAIRES.each do |nom, code|
      @factures_par_periode[code] = {}
      Facture.where(periode_budgetaire: code).each do |f|
        @factures_par_periode[code][f.periode] = f
      end
    end
  end

  private

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
