Rails.application.routes.draw do
  root "static_pages#home"

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users, param: :user_id
  namespace :user, path: 'users/:user_id/' do
    resources :posts do
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  # resources :users do
  #   resources :posts
  # end
end
