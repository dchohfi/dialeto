class PerfisController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def auto_complete
    @perfis = Perfil.where("nome like ?", "%#{params[:q]}%")
    
    respond_to do |format|
      format.json { render :json => @perfis.map(&:attributes)}
    end
  end
  
  def index
    @perfis = Perfil.all

    respond_to do |format|
      format.html
      format.json  { render :json => @perfis }
    end
  end

  def new
    @perfil = Perfil.new

    respond_to do |format|
      format.html
      format.json  { render :json => @perfil }
    end
  end

  def edit
    @perfil = Perfil.find(params[:id])
  end

  def create
    @perfil = Perfil.new(params[:perfil])
    
    if @perfil.save
      redirect_to(perfis_path, :notice => 'Perfil criado com sucesso.')
    else
      render :action => "new"
    end
  end

  def update
    @perfil = Perfil.find(params[:id])

    if @perfil.update_attributes(params[:perfil])
      redirect_to(perfis_path, :notice => 'Perfil atualizado com sucesso.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @perfil = Perfil.find(params[:id])
    @perfil.destroy

    redirect_to(perfis_url)
  end
end
