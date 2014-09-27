class DropsController < ApplicationController
  before_action :set_drop, only: [:show, :edit, :update, :destroy]

  # GET /drops
  # GET /drops.json
  def index
    set_drops
end

  # GET /drops/1
  # GET /drops/1.json
  def show
  end

  # GET /drops/new
  def new
    @drop = Drop.new
  end

  # GET /drops/1/edit
  def edit
  end

  # POST /drops
  # POST /drops.json
  def create
    @drop = Drop.new(drop_params)

    respond_to do |format|
      if @drop.save
        format.html { redirect_to drops_path, notice: 'Drop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @drop }
      else
        format.html { render action: 'new' }
        format.json { render json: @drop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drops/1
  # PATCH/PUT /drops/1.json
  def update
    respond_to do |format|
      if @drop.update(drop_params)
        format.html { redirect_to drops_path, notice: 'Drop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @drop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drops/1
  # DELETE /drops/1.json
  def destroy
    @drop.destroy
    respond_to do |format|
      format.html { redirect_to drops_url, notice: 'Drop was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def multi_ops
    params[:drop_ids] ||= []

    # html: name="delete_btn"
    if params[:delete_btn]
      del_cnt = Drop.delete(params[:drop_ids])
      redirect_to drops_url, notice: "#{del_cnt} records were successfully deleted. "
    elsif params[:copy_btn]
      copied_cnt = Drop.multi_copy(params[:drop_ids], params[:from_dtpker], params[:to_dtpker])
      redirect_to drops_url, notice: "#{copied_cnt} records were successfully copied. "
    elsif params[:export_btn]
      set_drops
      send_data @drops.to_csv
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drop
      @drop = Drop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drop_params
      params.require(:drop).permit(:today, :getup_at, :sleep_at, :is_alarm, :step, :km, :kcal, :pp, :xx, :comment, :weather_ids => [])
    end

    # get drops by start/end date
    def set_drops
      db_date_format = "%Y-%m-%d"

      if params[:from_date_picker].nil?
        session[:from_date_picker] ||= (Date.today - 7).strftime(db_date_format)
        session[:to_date_picker] ||= Date.today.strftime(db_date_format)

        params[:from_date_picker] = session[:from_date_picker]
        params[:to_date_picker] = session[:to_date_picker]
      end

      session[:from_date_picker] = params[:from_date_picker]
      session[:to_date_picker] = params[:to_date_picker]

      @drops = Drop.where(["today >= ? and today <= ?", params[:from_date_picker], params[:to_date_picker]]).order("today ASC")
    end
end
