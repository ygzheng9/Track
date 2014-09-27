class SegmentsController < ApplicationController
  before_action :set_segment, only: [:show, :edit, :update, :destroy]

  # GET /segments
  # GET /segments.json
  def index
    if session[:drop_id].nil?
      redirect_to drops_path
    else
      @drop = Drop.find(session[:drop_id])
      @drop.update_alignment
    
      @segments = @drop.segments.order("is_valid, start asc")
    end 
  end

  def index_nested
    session[:drop_id] = params[:drop_id]
    @drop = Drop.find(session[:drop_id])
    @drop.update_alignment
    
    @segments = @drop.segments.order("is_valid, start asc") 

    render "index"
  end 

  # GET /segments/1
  # GET /segments/1.json
  def show
  end

  # GET /segments/new
  def new
    if session[:drop_id].nil?
      @segment = Segment.new
    else
      @drop = Drop.find(session[:drop_id])
      @segment = @drop.segments.new
    end 
  end

  # GET /segments/1/edit
  def edit
    @drop = Drop.find(session[:drop_id]) unless session[:drop_id].nil?
  end

  # POST /segments
  # POST /segments.json
  def create   
    if session[:drop_id].nil?
      @segment = Segment.new(segment_params)
    else
      @drop = Drop.find(session[:drop_id])
      @segment = @drop.segments.new(segment_params)
    end

    @segment.is_valid = 1
    respond_to do |format|
      if @segment.save
        format.html { redirect_to list_target_url, notice: 'Segment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @segment }
      else
        format.html { render action: 'new' }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /segments/1
  # PATCH/PUT /segments/1.json
  def update
    respond_to do |format|
      if @segment.update(segment_params)
        format.html { redirect_to list_target_url, notice: 'Segment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /segments/1
  # DELETE /segments/1.json
  def destroy
    @segment.destroy
    respond_to do |format|
      format.html { redirect_to list_target_url, notice: 'Segment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_segment
      @segment = Segment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def segment_params
      params.require(:segment).permit(:start, :end, :step, :km, :kcal, :comment)
    end

    # based on session[:city_id]
    def list_target_url
      target_url = segments_path
      unless session[:drop_id].nil?
        @drop = Drop.find(session[:drop_id])
        target_url = drop_segments_path(@drop)
      end    
      return target_url   
    end     
end
