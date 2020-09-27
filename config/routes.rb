# coding: utf-8
Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
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
