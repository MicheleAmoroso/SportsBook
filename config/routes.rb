Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :homepage 
  resources :grounds do
    resources :books
    resources :reviews
  end
  

  get '/callback' => 'session#create'
  get '/login' => 'session#login'
  root 'homepage#index'
end
