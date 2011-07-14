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
      format.html # index.html.erb
      format.xml  { render :xml => @perfis }
      format.json  { render :json => @perfis }
    end
  end

  def new
    @perfil = Perfil.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @perfil }
      format.json  { render :json => @perfil }
    end
  end

  def edit
    @perfil = Perfil.find(params[:id])
  end

  def create
    @perfil = Perfil.new(params[:perfil])

    respond_to do |format|
      if @perfil.save
        format.html { redirect_to(perfis_path, :notice => 'Perfil criado com sucesso.') }
        format.xml  { render :xml => @perfil, :status => :created, :location => @perfil }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @perfil.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @perfil = Perfil.find(params[:id])

    respond_to do |format|
      if @perfil.update_attributes(params[:perfil])
        format.html { redirect_to(perfis_path, :notice => 'Perfil atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @perfil.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @perfil = Perfil.find(params[:id])
    @perfil.destroy

    respond_to do |format|
      format.html { redirect_to(perfis_url) }
      format.xml  { head :ok }
    end
  end
end
