Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  get 'login', to: 'home#login'
  get 'logout', to: 'home#logout'

  get 'foos', to: 'foos#index'
  post 'foos/sell', to: 'foos#sell'
  post 'foos/buy', to: 'foos#buy'

  match 'onMatchFinished/:key', to: 'webhook#suso_refresh', via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/auth/failure', to: 'sessions#auth_failure'
end
