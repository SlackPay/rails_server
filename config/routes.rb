Rails.application.routes.draw do

  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :status, only: [:index]
  resources :send, only: [:create]
end
