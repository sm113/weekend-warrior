Rails.application.routes.draw do
  devise_for :users
  
  root "pages#home"
  
  resources :organizations
  resources :events, only: [:index, :show, :new, :create]
end
