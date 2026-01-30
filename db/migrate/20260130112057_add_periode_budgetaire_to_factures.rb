class AddPeriodeBudgetaireToFactures < ActiveRecord::Migration[7.1]
  def change
    add_column :factures, :periode_budgetaire, :string
  end
end
