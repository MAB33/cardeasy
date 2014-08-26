Rails.application.routes.draw do

  get 'card_templates/index'

  get 'card_templates/show'

  get 'orders/new'

  devise_for :users

  resources :card_templates

  resources :users do
  	resources :addresses
  	resources :cards
  	resources :orders
    resources :cardlings
  end

  get 'home' => 'home#index'

  get 'add_to_cart' => 'orders#add_to_cart'
  post 'add_to_cart' => 'orders#add_to_cart'

  get 'remove_from_cart' => 'orders#remove_from_cart'
  post 'remove_from_cart' => 'orders#remove_from_cart'

  get 'empty_cart' => 'orders#empty'
  post 'empty_cart' => 'orders#empty'

  get 'checkout' => 'orders#checkout'
  post 'checkout' => 'orders#checkout'
  
  root 'home#index'

  get 'profile' => 'profile#show'

  post 'login_to_personalize' => 'card_templates#login_to_personalize'

end
