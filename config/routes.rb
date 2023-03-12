Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
get '/users', to: 'users#index', defaults: {format: 'json'}
post '/users', to: 'users#create', defaults: {format: 'json'}
post '/sign_in', to: 'sessions#create'
  resources :users
end
