Isharelib::Application.routes.draw do
  resources :people

  resources :movies

  root :to => "movies#index"
end
