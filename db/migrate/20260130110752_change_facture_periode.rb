class ChangeFacturePeriode < ActiveRecord::Migration[7.1]
  def change
    remove_column :factures, :date_facture, :date
    remove_column :factures, :periode_debut, :date
    remove_column :factures, :periode_fin, :date
    add_column :factures, :periode, :string, null: false, default: ""
  end
end
