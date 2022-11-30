Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'listeditems', to: 'products#listed_items', as: 'listeditems'
  get 'purchaseditems', to: 'products#purchased_items', as: 'purchaseditems'
  get 'solditems', to: 'products#sold_items', as: 'solditems'
end
