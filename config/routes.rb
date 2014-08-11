Rails.application.routes.draw do
  devise_for :users

  get 'home' => 'home#index'
  
  root 'home#index'

end
