Rails.application.routes.draw do

  devise_for :users

  resources :users do
  	resources :address
  end

  get 'home' => 'home#index'
  
  root 'home#index'

end
