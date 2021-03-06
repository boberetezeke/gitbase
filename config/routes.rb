Rails.application.routes.draw do
  if RUBY_ENGINE != 'opal'
    devise_for :users
  else
    resource :user_session
  end

  resources :pages do
    collection do
      get :tables
    end
  end

  resources :users

  root to: "pages#index"
end
