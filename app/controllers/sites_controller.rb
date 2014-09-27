class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    session[:city_id] = nil
    @sites = Site.all.order("city_id asc, name")
  end

  def index_nested
    session[:city_id] = params[:city_id]
    @city = City.find(session[:city_id])    

    @sites = @city.sites
    render "index"
  end 

  # GET /sites/1
  # GET /sites/1.json
  def show
  end 

  # GET /sites/new
  def new
    if session[:city_id].nil? 
      @site = Site.new
    else
      @city = City.find(session[:city_id])
      @site = @city.sites.new      
    end 
  end

  # GET /sites/1/edit
  def edit
    @city = City.find(session[:city_id]) unless session[:city_id].nil?
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to list_target_url, notice: 'Site was successfully created.' }
        format.json { render action: 'show', status: :created, location: @site }
      else
        format.html { render action: 'new' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to list_target_url, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to list_target_url, notice: "Site was successfully deleted. " }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.    
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:city_id, :name)
    end

    # based on session[:city_id]
    def list_target_url
      target_url = sites_path
      unless session[:city_id].nil?
        @city = City.find(session[:city_id])
        target_url = city_sites_path(@city)
      end    
      return target_url   
    end 
end
