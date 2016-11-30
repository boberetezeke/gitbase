Rails.application.routes.draw do
  devise_for :users
  resources :pages
  resources :users

  root to: "pages#index"
end
