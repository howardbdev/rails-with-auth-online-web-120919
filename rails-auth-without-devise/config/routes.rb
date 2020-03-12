Rails.application.routes.draw do
  root to: "sessions#new"
  get "/auth/google_oauth2/callback", to: "sessions#create_with_google_oauth"
  get '/login', to: "sessions#new", as: "login"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
