#encoding: utf-8
class UserController < ApplicationController
  load_and_authorize_resource
  
  def index
    @users = User.all.delete_if {|user| user.id == current_user.id}
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuário criado com sucesso."
      redirect_to user_index_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update  
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?    
    if @user.update_attributes(params[:user])
      flash[:notice] = "Usuário alterado com sucesso."
      redirect_to user_index_path
    else
      render :action => 'edit'
    end
  end
  
end