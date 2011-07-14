class VideosController < ApplicationController
  before_filter :authenticate_user!

  def index    
    @videos = []
    if params[:id_categoria]
      if(can? :manage, Video)
        categoria = Categoria.find(params[:id_categoria])
      else
        categoria = Categoria.categorias_do_usuario(current_user).where(:id => params[:id_categoria]).first
      end
      render :status => 404 if categoria.nil?
      @videos = categoria.videos
    elsif can? :manage, Video
      @videos = Video.all
    else
      @videos = Video.videos_do_usuario(current_user)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @videos }
    end
  end

  def show
    @video = Video.find(params[:id])

    unless can? :manage, Video
      @video = nil unless Video.videos_do_usuario.include? @video
    end

    if @video
      respond_to do |format|
        format.html # show.html.erb
        format.json  { render :json => @videos }
      end
    elsif
      respond_to do |format|
        format.html { redirect_to(videos_url) }
      end
    end
  end

  def new
    @video = Video.new
    images = []
    3.times do
      image = Image.new
      image.owner = @video
      images << image
    end
    @video.images = images
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def create
    @video = Video.new(params[:video])
    
    respond_to do |format|
      if @video.save
        format.html { redirect_to(@video, :notice => 'Video criado com sucesso.') }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @video = Video.find(params[:id])
    params[:video].delete(:media) if params[:video][:media].blank?
    
    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to(@video, :notice => 'Video atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end
end
