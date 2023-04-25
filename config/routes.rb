Rails.application.routes.draw do
  devise_for :users
  root "projects#index"
  resources :items
  resources :projects
end
