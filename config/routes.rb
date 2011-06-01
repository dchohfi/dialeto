Dialeto::Application.routes.draw do
  resources :videos
  resources :propagandas
  resources :categorias
  resources :perfis
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  
  resources :token_authentications, :only => [:create, :destroy]
  resources :user, :controller => "user"
  
  resources :dashboard

  match 'categorias/:id_categoria/propagandas' => 'propagandas#index'
  match 'categorias/:id_categoria/videos' => 'videos#index'

  # map.resources :categorias, :has_many => :images
  # map.resources :videos, :has_many => :images

  # match 'categorias/:id_categoria/videos(/:id_video)' => "controller#acao"

  root :to => "perfis#index"
end
