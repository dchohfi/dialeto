class VideosController < ApplicationController
  before_filter :authenticate_user!, :except => :validate_video
  protect_from_forgery :except => :validate_video
  load_and_authorize_resource
  skip_authorize_resource :only => :validate_video

  def index    
    if can? :manage, Video
      @videos = Video.all
    else
      @videos = Video.videos_do_usuario(current_user).where(:status => 'completed')
    end
    respond_to do |format|
      format.html
      format.json  { render :json => @videos }
    end
  end
  
  def videos_da_categoria
    if(can? :manage, Video)
      categoria = Categoria.find(params[:id_categoria])
    else
      categoria = Categoria.categorias_do_usuario(current_user).where(:id => params[:id_categoria]).first
    end
    raise ActiveRecord::RecordNotFound.new if categoria.nil?
    @videos = categoria.videos.find_all{ |video| video.completed? }
    
    respond_to do |format|
      format.html { render :template => "videos/index.html.erb" }
      format.json  { render :json => @videos }
    end
  end
  
  def validate_video
    params_validated = params['event'] && params['event'] == 'video-encoded' && params['video_id'] && !params['video_id'].blank?
    if params_validated
      video = Video.find_by_panda_video_id(params['video_id'])
      if video
        panda_video = Panda::Video.find(video.panda_video_id)
        encoded_video = panda_video.encodings.first

        video.original_file_name = panda_video.original_filename
        video.content_type = encoded_video.extname
        video.file_size = encoded_video.height
        video.file_name = encoded_video.path
        video.status = 'completed'
        
        if video.save!
          render :nothing => true, :status => 200
        else
          render :nothing => true, :status => 500
        end
        return
      end
    end
    render :nothing => true, :status => 200
  end

  def show
    @video = Video.find(params[:id])

    unless can? :manage, Video
      @video = nil unless Video.videos_do_usuario.include? @video
    end
    
    if @video
      @encoded_video = @video.panda_video.encodings.first
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
