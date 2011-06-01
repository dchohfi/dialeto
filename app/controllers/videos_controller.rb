class VideosController < ApplicationController
  before_filter :authenticate_user!
  # GET /videos
  # GET /videos.json
  def index
    
    if params[:id_categoria]
      @videos = Categoria.find(params[:id_categoria]).videos
    elsif can? :manage, Video
      @videos = Video.all
    else
      @videos = current_user.videos
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @videos.to_json( :methods => [:tag_list, :images_url, :authenticated_media_url, :include => {:categorias => {:only => [ :id]}}])}
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])

    if(!(can? :manage, Video))
      @video = nil unless current_user.videos.include? @video
    end

    if @video
      respond_to do |format|
        format.html # show.html.erb
        format.json  { render :json => @video.to_json( :methods => [:tag_list, :images_url, :authenticated_media_url, :include => {:categorias => {:only => [ :id]}}])}
      end
    elsif
      respond_to do |format|
        format.html { redirect_to(videos_url) }
      end
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
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

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])
    
    respond_to do |format|
      if @video.save
        format.html { redirect_to(@video, :notice => 'Video was successfully created.') }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])
    params[:video].delete(:media) if params[:video][:media].blank?
    
    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to(@video, :notice => 'Video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end
end
