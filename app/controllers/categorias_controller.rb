class CategoriasController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def auto_complete
    @categorias = Categoria.where("lower(nome) like ?", "%#{params[:q]}%")
    
    respond_to do |format|
      format.json { render :json => @categorias.map(&:attributes)}
    end
  end

  def index
    if can? :manage, Categoria
      @categorias = Categoria.all
    elsif
      @categorias = Categoria.categorias_do_usuario(current_user)
    end
    
    respond_to do |format|
      format.html
      format.json  { render :json => @categorias }
    end
  end

  def show
    @categoria = Categoria.find(params[:id])

    if(!(can? :manage, Categoria))
      @categoria = nil unless Categoria.categorias_do_usuario(current_user).include? @categoria
    end
    
    if @categoria
      respond_to do |format|
        format.html
        format.json  { render :json => @categoria }
      end
    elsif
      respond_to do |format|
        format.html { redirect_to(categorias_url) }
      end
    end
  end

  def new
    @categoria = Categoria.new
    images = []
    3.times do
      image = Image.new
      image.owner = @categoria
      images << image
    end
    @categoria.images = images
  end

  def edit
    @categoria = Categoria.find(params[:id])
  end

  def create
    @categoria = Categoria.new(params[:categoria])

    if @categoria.save
      redirect_to(@categoria, :notice => 'Categoria criada com sucesso.')
    else
      render :action => "new"
    end
  end

  def update
    @categoria = Categoria.find(params[:id])

    if @categoria.update_attributes(params[:categoria])
      redirect_to(@categoria, :notice => 'Categoria atualizada com sucesso.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @categoria = Categoria.find(params[:id])
    @categoria.destroy
    
    redirect_to(categorias_url)
  end

end