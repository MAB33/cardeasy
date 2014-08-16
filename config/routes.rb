Rails.application.routes.draw do

  devise_for :users

  resources :users do
  	resources :address
  	resources :card
  end

  get 'home' => 'home#index'
  
  root 'home#index'

  post 'create_addresses_orders' => 'card#create_addresses_orders'
  get 'create_addresses_orders' => 'card#create_addresses_orders'

end
