# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_01_30_112057) do
  create_table "factures", force: :cascade do |t|
    t.decimal "index_precedent", precision: 10, scale: 2
    t.decimal "index_actuel", precision: 10, scale: 2
    t.decimal "consommation_m3", precision: 10, scale: 2
    t.decimal "montant_ht", precision: 10, scale: 2
    t.decimal "montant_ttc", precision: 10, scale: 2, null: false
    t.decimal "prix_unitaire_m3", precision: 10, scale: 4
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "periode", default: "", null: false
    t.string "periode_budgetaire"
  end

end
