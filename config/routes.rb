Rails.application.routes.draw do
  root to: "static_pages#home"

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  # resources :users, param: :user_id
  # namespace :user, path: "users/:user_id/" do
  #   resources :posts, only: [ :index, :new, :create, :show, :destroy ] do
  #     resources :comments, only: [ :create, :destroy ]
  #     resource :favorites, only: [ :create, :destroy ]
  #   end
  # end

  resources :users do
    # namespace :user, path: "users/:user_id/" do
    resources :posts, only: [ :index, :new, :create, :show, :destroy ] do
      resources :comments, only: [ :create, :destroy ]
      resource :favorites, only: [ :create, :destroy ]
    end
  end
end
