Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: %i[new create show]
  resources :products do
    resources :transactions, only: :create
  end
  get 'transactions/:id/confirmation', to: 'transactions#confirmation', as: 'confirmation'
  get 'dashboard', to: 'pages#user_dash', as: 'dashboard'
  get 'about', to: 'pages#about_us', as: 'aboutpage'
  get 'basket', to: 'transactions#basket', as: 'basket'
end
