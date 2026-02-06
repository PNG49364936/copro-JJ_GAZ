class Facture < ApplicationRecord
  PERIODES = [
    ["Total annuel", "total"],
    ["Septembre", "septembre"],
    ["Octobre", "octobre"],
    ["Novembre", "novembre"],
    ["Décembre", "decembre"],
    ["Janvier", "janvier"],
    ["Février", "fevrier"],
    ["Mars", "mars"],
    ["Avril", "avril"],
    ["Mai", "mai"]
  ].freeze

  PERIODES_BUDGETAIRES = [
    ["2023/2024", "2023_2024"],
    ["2024/2025", "2024_2025"],
    ["2025/2026", "2025_2026"],
    ["2026/2027", "2026_2027"]
  ].freeze

  validates :periode, presence: true, inclusion: { in: PERIODES.map(&:last) }
  validates :periode_budgetaire, presence: true, inclusion: { in: PERIODES_BUDGETAIRES.map(&:last) }
  validates :montant_ttc, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :consommation_m3, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :montant_ht, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  before_save :calculer_prix_unitaire

  scope :par_date, -> { order(:created_at => :desc) }

  def periode_nom
    PERIODES.find { |p| p.last == periode }&.first || periode
  end

  def periode_budgetaire_nom
    PERIODES_BUDGETAIRES.find { |p| p.last == periode_budgetaire }&.first || periode_budgetaire
  end

  private

  def calculer_prix_unitaire
    if consommation_m3.present? && consommation_m3 > 0 && montant_ttc.present?
      self.prix_unitaire_m3 = montant_ttc / consommation_m3
    end
  end
end
