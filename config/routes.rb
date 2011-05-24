Dialeto::Application.routes.draw do
  resources :propagandas

  resources :categorias

  resources :categoria

  resources :perfis

  devise_for :users

  root :to => "perfis#index"
end
