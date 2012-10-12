Courier::Application.routes.draw do
  ActiveAdmin.routes(self)

  get "/" => "home#index"

  resources :clients
  resources :jobs do
    collection do
      get "summary"
    end
    member do
      get "cancel"
      get "summary"
    end
    resources :drops
  end

  resources :location_update
  resources :locations do
    collection do
      match "search"
    end
  end

  devise_for :users
  resources :users, :only => [:show, :index]
end
