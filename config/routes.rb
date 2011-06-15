Dialeto::Application.routes.draw do
  resources :videos
  resources :propagandas
  resources :categorias
  resources :perfis
  
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  
  resources :token_authentications, :only => [:create, :destroy]
  resources :user, :controller => "user"
  resources :users
  
  resources :dashboard

  match 'categorias/:id_categoria/propagandas' => 'propagandas#index'
  match 'categorias/:id_categoria/videos' => 'videos#index'

  root :to => "perfis#index"
end
