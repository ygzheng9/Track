class WorkingLocationsController < ApplicationController
  before_action :set_working_location, only: [:show, :edit, :update, :destroy]

  # GET /working_locations
  # GET /working_locations.json
  def index
    db_date_format = "%Y-%m-%d"

    if params[:from_date_picker].nil?
      session[:from_date_picker] ||= (Date.today - 7).strftime(db_date_format)
      session[:to_date_picker] ||= Date.today.strftime(db_date_format)

      params[:from_date_picker] = session[:from_date_picker]
      params[:to_date_picker] = session[:to_date_picker]
    end 
    
    session[:from_date_picker] = params[:from_date_picker]
    session[:to_date_picker] = params[:to_date_picker]

    @working_locations = WorkingLocation.where(["today >= ? and today <= ?", params[:from_date_picker], params[:to_date_picker]]).order(today: :asc)   
    @working_location = WorkingLocation.new
    
    @cities = City.all 
    @sites = @cities.first.sites    
  end

  # GET /working_locations/1
  # GET /working_locations/1.json
  def show
    if params[:opt] == "copy"
      target_date = Date.today

      @working_location.CopyWholeDay(target_date)

      redirect_to action: :index 
    end     
  end

  # GET /working_locations/new
  def new
    @working_location = WorkingLocation.new

    @cities = City.all 
    @sites = @cities.first.sites
  end

  def new_v2
    @working_location = WorkingLocation.new

    @cities = City.all 
    @sites = @cities.first.sites
  end


  # GET /working_locations/1/edit
  def edit
    @cities = City.all 
    @sites = @working_location.site.city.sites

    respond_to do |format|
      format.js
    end 
  end

  # POST /working_locations
  # POST /working_locations.json
  def create
    if params[:commit].casecmp("go") == 0
      @working_location = WorkingLocation.new(working_location_params)

      respond_to do |format|
        if @working_location.save
          format.html { redirect_to working_locations_path, notice: 'Working location was successfully created.' }
          format.json { render action: 'show', status: :created, location: @working_location }
          format.js
        else
          format.html { render action: 'new_v2' }
          format.json { render json: @working_location.errors, status: :unprocessable_entity }
        end
      end
    elsif params[:commit].casecmp("Cancel") == 0
      respond_to do |format|
        format.js { render "cancel" }
      end 
    end    
  end

  # PATCH/PUT /working_locations/1
  # PATCH/PUT /working_locations/1.json
  def update
    if params[:commit] == "Go"  
      respond_to do |format|
        if @working_location.update(working_location_params)
          format.html { redirect_to working_locations_path, notice: 'Working location was successfully updated.' }
          format.json { head :no_content }
          format.js
        else
          format.html { render action: 'edit' }
          format.json { render json: @working_location.errors, status: :unprocessable_entity }
        end
      end
    elsif params[:commit] == "Cancel"
      respond_to do |format|
        format.js { render "cancel" }
      end 
    end
  end

  # DELETE /working_locations/1
  # DELETE /working_locations/1.json
  def destroy
    @working_location.destroy
    respond_to do |format|
      format.html { redirect_to working_locations_url }
      format.json { head :no_content }
      format.js
    end
  end

  # get site based on city changed
  def get_sites 
      @sites = Site.where(["city_id = ?", params[:city_id]])

      logger.debug("city_id: #{params[:city_id]}")

      respond_to do |format|
        format.json  { render :json => @sites }      
      end
  end   

  # copy selected items 
  def multi_ops
    params[:location_ids] ||= []

    if params[:delete_btn] 
      del_cnt = WorkingLocation.delete(params[:location_ids])
      redirect_to working_locations_url, notice: "#{del_cnt} records were successfully deleted. "
    else
      copied_cnt = WorkingLocation.multi_copy(params[:location_ids], params[:from_dtpker], params[:to_dtpker])
      redirect_to working_locations_url, notice: "#{copied_cnt} records were successfully copied. "
    end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_working_location
      @working_location = WorkingLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def working_location_params
      params.require(:working_location).permit(:today, :site_id, :Taxi, :comment)
    end
end
