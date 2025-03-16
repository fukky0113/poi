Rails.application.routes.draw do
  get "comments/new"
  root "static_pages#home"

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users
  resources :posts

end
