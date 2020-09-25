Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :homepage 
  resources :grounds do
    resources :book
  end

  
  root 'homepage#index'
end
