Rails.application.routes.draw do
  resources :properties
  root to: 'home#index'

  resources :stocks
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
