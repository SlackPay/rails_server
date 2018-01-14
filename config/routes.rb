Rails.application.routes.draw do

  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :status, only: [:index]
  resources :send, only: [:create]

  post "/users/set_address" => "users#set_address"
  post "/users/view_address" => "users#view_address"
  post "/users/check_balance" => "users#check_balance"
end
