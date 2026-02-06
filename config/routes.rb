Rails.application.routes.draw do
  resources :factures
  get "tableau_couts", to: "factures#tableau_couts", as: :tableau_couts
  get "tableau_comparaison", to: "factures#tableau_comparaison", as: :tableau_comparaison

  get "up" => "rails/health#show", as: :rails_health_check

  root "factures#index"
end
