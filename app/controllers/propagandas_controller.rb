class PropagandasController < ApplicationController
  before_filter :authenticate_user!  
  # GET /propagandas
  # GET /propagandas.xml
  def index
    @propagandas = Propaganda.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @propagandas }
      format.json { render :json => @propagandas}
    end
  end

  # GET /propagandas/1
  # GET /propagandas/1.xml
  def show
    @propaganda = Propaganda.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @propaganda }
      format.json { render :json => @propaganda.to_json( :methods => [:image_url] )  }
    end
  end

  # GET /propagandas/new
  # GET /propagandas/new.xml
  def new
    @propaganda = Propaganda.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @propaganda }
    end
  end

  # GET /propagandas/1/edit
  def edit
    @propaganda = Propaganda.find(params[:id])
  end

  # POST /propagandas
  # POST /propagandas.xml
  def create
    @propaganda = Propaganda.new(params[:propaganda])
    respond_to do |format|
      if @propaganda.save
        format.html { redirect_to(@propaganda, :notice => 'Propaganda was successfully created.') }
        format.xml  { render :xml => @propaganda, :status => :created, :location => @propaganda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @propaganda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /propagandas/1
  # PUT /propagandas/1.xml
  def update
    @propaganda = Propaganda.find(params[:id])

    respond_to do |format|
      if @propaganda.update_attributes(params[:propaganda])
        format.html { redirect_to(@propaganda, :notice => 'Propaganda was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @propaganda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /propagandas/1
  # DELETE /propagandas/1.xml
  def destroy
    @propaganda = Propaganda.find(params[:id])
    @propaganda.destroy

    respond_to do |format|
      format.html { redirect_to(propagandas_url) }
      format.xml  { head :ok }
    end
  end
end
