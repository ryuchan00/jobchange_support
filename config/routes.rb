Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]

  resources :items, only: [:show, :new]
  resources :ownerships, only: [:create, :destroy]

  get 'rankings/want', to: 'rankings#want'
  get 'rankings/have', to: 'rankings#have'

  get 'auth/:provider/callback', to: 'sessions#create_tw'
  get '/logout_tw', to: 'sessions#destroy_tw'

  get 'github', to: 'links#github'
  get 'github/new', to: 'links#github_new'
  get 'links/create', to: 'links#create'
  post 'links/create', to: 'links#create'
end
