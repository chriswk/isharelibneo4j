Isharelib::Application.routes.draw do
  resources :people

  resources :movies do
    member do
      get 'fetch_tmdb'
    end
  end

  root :to => "movies#index"
end
