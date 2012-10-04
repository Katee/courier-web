Courier::Application.routes.draw do
  ActiveAdmin.routes(self)

  resources :clients
  resources :jobs
  resources :location_update
  resources :locations
  resources :drops

  get "/" => "home#index"

  devise_for :users
  resources :users, :only => [:show, :index]
end
