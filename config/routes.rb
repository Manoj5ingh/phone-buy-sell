Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#index'
  get '/login', to: 'static#index'
  resources :users, only: [:create, :show, :index]
  post '/login', to: 'session#create'
  get '/logged_in', to: 'session#is_logged_in?'
  delete '/logout', to: 'session#destroy'
  namespace :v1 do
    get 'customer/products'
    get 'customer/product/:id', to: 'customer#product'
    post 'customer/add_to_cart', to: 'customer#add_to_cart'
    get 'customer/show_cart', to: 'customer#show_cart'
    post 'customer/buy', to: 'customer#buys'
    post 'customer/buy/:pid', to: 'customer#buy_with_pid'
    get 'customer/track/:tracking_id', to: 'customer#get_track'
    
  end
end
