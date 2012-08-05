Courier::Application.routes.draw do
  resources :clients
  resources :jobs
  resources :location_update

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
end
