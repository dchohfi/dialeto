Dialeto::Application.routes.draw do
  match 'categorias/auto_complete' => 'categorias#auto_complete'
  match 'perfis/auto_complete' => 'perfis#auto_complete'
  match 'categorias/:id_categoria/propagandas' => 'propagandas#index'
  match 'categorias/:id_categoria/videos' => 'videos#index'
  
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  
  resources :token_authentications, :only => [:create, :destroy]
  resources :user, :controller => "user"
  resources :users
  resources :contatos
  resources :videos
  resources :propagandas
  resources :categorias
  resources :perfis

  root :to => "perfis#index"
end
