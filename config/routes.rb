Rails.application.routes.draw do
  resources :factures
  get "tableau_couts", to: "factures#tableau_couts", as: :tableau_couts

  get "up" => "rails/health#show", as: :rails_health_check

  root "factures#index"
end
