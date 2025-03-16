Rails.application.routes.draw do
  root "static_pages#home"

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users, param: :user_id
  namespace :user, path: 'users/:user_id/' do
    resources :posts
  end

  # resources :users do
  #   resources :posts
  # end
end
