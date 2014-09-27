class StayNightsController < ApplicationController
  before_action :set_stay_night, only: [:show, :edit, :update, :destroy]

  # GET /stay_nights
  # GET /stay_nights.json
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

    @stay_nights = StayNight.where(["today >= ? and today <= ?", params[:from_date_picker], params[:to_date_picker]]).order(today: :asc)
    @stay_night = StayNight.new

  end

  # GET /stay_nights/1
  # GET /stay_nights/1.json
  def show
    if params[:opt] == "copy"
      target_date = Date.today

      @stay_night.CopyWholeDay(target_date)

      redirect_to stay_nights_url
    end      
  end

  # GET /stay_nights/new
  def new
    @stay_night = StayNight.new
  end

  # GET /stay_nights/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end 
  end

  # POST /stay_nights
  # POST /stay_nights.json
=begin   
  def create
    if params[:commit] == "Go"
      @stay_night = StayNight.new(stay_night_params)

      respond_to do |format|
        if @stay_night.save
          format.html { redirect_to @stay_night, notice: 'Stay night was successfully created.' }
          format.json { render action: 'show', status: :created, location: @stay_night }
          format.js
        else
          format.html { render action: 'new' }
          format.json { render json: @stay_night.errors, status: :unprocessable_entity }
        end
      end
    elsif params[:commit] == "Cancel"
      respond_to do |format|
        format.js { render "cancel" }
      end 
    end
  end
=end 
 def create
  @stay_night = StayNight.new(stay_night_params)

  respond_to do |format|
    if @stay_night.save
      format.html { redirect_to stay_nights_url, notice: 'Record was successfully created.' }
      format.json { render action: 'show', status: :created, location: @stay_night }
      format.js
    else
      format.html { render action: 'new' }
      format.json { render json: @stay_night.errors, status: :unprocessable_entity }
    end
  end
  end

  # PATCH/PUT /stay_nights/1
  # PATCH/PUT /stay_nights/1.json
=begin
  def update
    if params[:commit] == "Go"
      respond_to do |format|
        if @stay_night.update(stay_night_params)
          format.html { redirect_to @stay_night, notice: 'Stay night was successfully updated.' }
          format.json { head :no_content }
          format.js
        else
          format.html { render action: 'edit' }
          format.json { render json: @stay_night.errors, status: :unprocessable_entity }
        end
      end
    elsif params[:commit] == "Cancel"
      respond_to do |format|
        format.js { render "cancel" }
      end 
    end
  end
=end

  def update
    respond_to do |format|
      if @stay_night.update(stay_night_params)
        format.html { redirect_to stay_nights_url, notice: 'record was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @stay_night.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stay_nights/1
  # DELETE /stay_nights/1.json
  def destroy
    @stay_night.destroy
    respond_to do |format|
      format.html { redirect_to stay_nights_url }
      format.json { head :no_content }
      format.js
    end
  end

  # copy selected items 
  def multi_ops
    params[:stay_night_ids] ||= []

    if params[:update_btn]
      @stay_nights = StayNight.find(params[:stay_night_ids])
      @stay_night = StayNight.new

      render "batch_update"
    elsif params[:delete_btn] 
      del_cnt = StayNight.delete(params[:stay_night_ids])
      redirect_to stay_nights_url, notice: "#{del_cnt} records were successfully deleted. "
    else
      copied_cnt = StayNight.multi_copy(params[:stay_night_ids], params[:from_dtpker], params[:to_dtpker])
      redirect_to stay_nights_url, notice: "#{copied_cnt} records were successfully copied. "
    end
  end 

  def batch_update
    # change code and hours 
    @stay_nights = StayNight.find(params[:stay_night_ids])
    cnt = @stay_nights.count

    night_params = params.require(:stay_night).permit(:city_id, :hotel_id, :rate, :comment)
    new_val = night_params.reject { |k,v| v.blank? }

    @stay_nights.each do |night|
      night.update_attributes(new_val)
    end 

    redirect_to stay_nights_url, notice: "#{cnt} records were successfully updated. "
  end     


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stay_night
      @stay_night = StayNight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stay_night_params
      params.require(:stay_night).permit(:today, :city_id, :hotel_id, :rate, :comment)
    end
end
