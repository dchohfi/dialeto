Dialeto::Application.routes.draw do
  resources :videos

  resources :propagandas

  resources :categorias

  resources :categoria

  resources :perfis

  devise_for :users

  root :to => "perfis#index"
end
