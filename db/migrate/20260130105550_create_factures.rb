class CreateFactures < ActiveRecord::Migration[7.1]
  def change
    create_table :factures do |t|
      t.date :date_facture, null: false
      t.date :periode_debut
      t.date :periode_fin
      t.decimal :index_precedent, precision: 10, scale: 2
      t.decimal :index_actuel, precision: 10, scale: 2
      t.decimal :consommation_m3, precision: 10, scale: 2
      t.decimal :montant_ht, precision: 10, scale: 2
      t.decimal :montant_ttc, precision: 10, scale: 2, null: false
      t.decimal :prix_unitaire_m3, precision: 10, scale: 4
      t.text :notes

      t.timestamps
    end
  end
end
