Dialeto::Application.routes.draw do
  resources :videos
  resources :propagandas
  resources :categorias
  resources :categoria
  resources :perfis
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  
  resources :token_authentications, :only => [:create, :destroy]
  resources :user, :controller => "user"
  
  resources :dashboard

  root :to => "perfis#index"
end
