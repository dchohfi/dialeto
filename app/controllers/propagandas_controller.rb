class PropagandasController < ApplicationController
  before_filter :authenticate_user!  
  # GET /propagandas
  # GET /propagandas.json
  def index
    @propagandas = []
    if params[:id_categoria]
      if can? :manage, Propaganda
        @propagandas = Categoria.find(params[:id_categoria]).propagandas        
      else
        categoria = current_user.categoria(params[:id_categoria])
        @propagandas = categoria.propagandas unless categoria.nil?
      end
    elsif can? :manage, Propaganda
      @propagandas = Propaganda.all
    elsif
      @propagandas = Propaganda.with_out_categoria
    end
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @propagandas }
    end
  end

  # GET /propagandas/1
  # GET /propagandas/1.json
  def show
    @propaganda = Propaganda.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @propaganda }
    end
  end

  # GET /propagandas/new
  def new
    @propaganda = Propaganda.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /propagandas/1/edit
  def edit
    @propaganda = Propaganda.find(params[:id])
  end

  # POST /propagandas
  def create
    @propaganda = Propaganda.new(params[:propaganda])
    respond_to do |format|
      if @propaganda.save
        format.html { redirect_to(@propaganda, :notice => 'Propaganda criada com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /propagandas/1
  def update
    @propaganda = Propaganda.find(params[:id])
    
    params[:propaganda].delete(:media) if params[:propaganda][:media].blank?
    params[:propaganda].delete(:image) if params[:propaganda][:image].blank?

    respond_to do |format|
      if @propaganda.update_attributes(params[:propaganda])
        format.html { redirect_to(@propaganda, :notice => 'Propaganda atualizada com sucesso.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /propagandas/1
  def destroy
    @propaganda = Propaganda.find(params[:id])
    @propaganda.destroy

    respond_to do |format|
      format.html { redirect_to(propagandas_url) }
    end
  end
end
