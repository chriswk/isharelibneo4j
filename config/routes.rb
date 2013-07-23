require 'sidekiq/web'
Isharelib::Application.routes.draw do
  resources :people
  resources :countries

  resources :movies do
    member do
      get 'fetch_tmdb'
    end
  end

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  root :to => "movies#index"
  end
