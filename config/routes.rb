Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  get 'login', to: 'home#login'
  get 'logout', to: 'home#logout'

  get 'foos', to: 'foos#index'
  post 'foos/sell', to: 'foos#sell'
  post 'foos/buy', to: 'foos#buy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/auth/:provider/callback', to: 'sessions#create'
end
