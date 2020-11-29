Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#index'
  get '/login', to: 'static#index'
  resources :users, only: [:create, :show, :index]
  post '/login', to: 'session#create'
  get '/logged_in', to: 'session#is_logged_in?'
  delete '/logout', to: 'session#destroy'
end
