class CategoriasController < ApplicationController
  before_filter :authenticate_user!
  # GET /categorias
  def index
    if can? :manage, Categoria
      @categorias = Categoria.all
    elsif
      @categorias = Categoria.categorias_do_usuario(current_user)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @categorias }
    end
  end

  # GET /categorias/1
  # GET /categorias/1.xml
  def show
    @categoria = Categoria.find(params[:id])

    if(!(can? :manage, Categoria))
      @categoria = nil unless Categoria.categorias_do_usuario(current_user).include? @categoria
    end
    
    if @categoria
      respond_to do |format|
        format.html # show.html.erb
        format.json  { render :json => @categoria }
      end
    elsif
      respond_to do |format|
        format.html { redirect_to(categorias_url) }
      end
    end
  end

  # GET /categorias/new
  # GET /categorias/new.xml
  def new
    @categoria = Categoria.new
    images = []
    3.times do
      image = Image.new
      image.owner = @categoria
      images << image
    end
    @categoria.images = images
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categoria }
    end
  end

  # GET /categorias/1/edit
  def edit
    @categoria = Categoria.find(params[:id])
  end

  # POST /categorias
  # POST /categorias.xml
  def create
    @categoria = Categoria.new(params[:categoria])
    respond_to do |format|
      if @categoria.save
        format.html { redirect_to(@categoria, :notice => 'Categoria was successfully created.') }
        format.xml  { render :xml => @categoria, :status => :created, :location => @categoria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @categoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categorias/1
  # PUT /categorias/1.xml
  def update
    @categoria = Categoria.find(params[:id])

    respond_to do |format|
      if @categoria.update_attributes(params[:categoria])
        format.html { redirect_to(@categoria, :notice => 'Categoria was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categorias/1
  # DELETE /categorias/1.xml
  def destroy
    @categoria = Categoria.find(params[:id])
    @categoria.destroy

    respond_to do |format|
      format.html { redirect_to(categorias_url) }
      format.xml  { head :ok }
    end
  end
end
