class PerfisController < ApplicationController
  before_filter :authenticate_user!
  # GET /perfis
  # GET /perfis.xml
  def index
    @perfis = Perfil.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @perfis }
      format.json  { render :json => @perfis }
    end
  end

  # GET /perfis/1
  # GET /perfis/1.xml
  def show
    @perfil = Perfil.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @perfil }
      format.json  { render :json => @perfil }
    end
  end

  # GET /perfis/new
  # GET /perfis/new.xml
  def new
    @perfil = Perfil.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @perfil }
      format.json  { render :json => @perfil
    end
  end

  # GET /perfis/1/edit
  def edit
    @perfil = Perfil.find(params[:id])
  end

  # POST /perfis
  # POST /perfis.xml
  def create
    @perfil = Perfil.new(params[:perfil])

    respond_to do |format|
      if @perfil.save
        format.html { redirect_to(@perfil, :notice => 'Perfil was successfully created.') }
        format.xml  { render :xml => @perfil, :status => :created, :location => @perfil }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @perfil.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /perfis/1
  # PUT /perfis/1.xml
  def update
    @perfil = Perfil.find(params[:id])

    respond_to do |format|
      if @perfil.update_attributes(params[:perfil])
        format.html { redirect_to(@perfil, :notice => 'Perfil was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @perfil.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /perfis/1
  # DELETE /perfis/1.xml
  def destroy
    @perfil = Perfil.find(params[:id])
    @perfil.destroy

    respond_to do |format|
      format.html { redirect_to(perfis_url) }
      format.xml  { head :ok }
    end
  end
end
