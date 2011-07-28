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
      format.html
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
        format.html
        format.json  { render :json => @videos }
      end
    elsif
      render :status => 404
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
  end

  def edit
    @video = Video.find(params[:id])
  end

  def create
    @video = Video.new(params[:video])
    
    if @video.save
      redirect_to(@video, :notice => 'Video criado com sucesso.')
    else
      render :action => "new"
    end
  end

  def update
    @video = Video.find(params[:id])
    params[:video].delete(:media) if params[:video][:media].blank?
    
    if @video.update_attributes(params[:video])
      redirect_to(@video, :notice => 'Video atualizado com sucesso.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    
    redirect_to(videos_url)
  end
end
