Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: %i[new create show] do
    get 'completedorders', to: 'users#completedorders', as: 'completedorder'
    get 'listeditems', to: 'users#listeditems', as: 'mylistings'
    get 'solditems', to: 'users#solditems', as: 'solditems'
  end
  resources :products do
    resources :transactions, only: :create
  end
  get 'transactions/:id/confirmation', to: 'transactions#confirmation', as: 'confirmation'
  get 'dashboard', to: 'pages#user_dash', as: 'dashboard'
  get 'about', to: 'pages#about_us', as: 'aboutpage'
  get 'basket', to: 'transactions#basket', as: 'basket'
  get 'completedorders', to: 'users#completedorders', as: 'completedorder'
  resources :transactions, only: :destroy
end
