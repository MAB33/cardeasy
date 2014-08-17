Rails.application.routes.draw do

  get 'orders/new'

  devise_for :users

  resources :users do
  	resources :addresses
  	resources :cards
  	resources :orders
  end

  get 'home' => 'home#index'

  get 'add_to_cart' => 'orders#add_to_cart'
  post 'add_to_cart' => 'orders#add_to_cart'

  get 'remove_from_cart' => 'orders#remove_from_cart'
  post 'remove_from_cart' => 'orders#remove_from_cart'

  get 'empty_cart' => 'orders#empty'
  post 'empty_cart' => 'orders#empty'
  
  root 'home#index'

end
