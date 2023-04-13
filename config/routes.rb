Rails.application.routes.draw do
  resources :items
  resources :projects
  # Define your application routes per the D

  #Defines the root path route ("/ ")
  root "projects#index"
  resources :projects
  
end
