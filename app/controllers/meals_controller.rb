class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    # get single day meals
    if session[:drop_id].nil?
      redirect_to drops_path
    else
      @drop = Drop.find(session[:drop_id])    
      @meals = @drop.meals.order("start asc")
    end    
  end

  def index_nested
    # get single day meals
    if params[:drop_id].nil? and session[:drop_id].nil?
      redirect_to drops_path
    else
      session[:drop_id] = params[:drop_id] unless params[:drop_id].nil?
      @drop = Drop.find(session[:drop_id])    
      @meals = @drop.meals.order("start asc")
    end   

    render "index" 
  end  

  # GET /meals/1
  # GET /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    if session[:drop_id].nil?
      redirect_to drops_path
    else
      @drop = Drop.find(session[:drop_id])    
      @meal = @drop.meals.new
    end      
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals
  # POST /meals.json
  def create
    if session[:drop_id].nil?
      redirect_to drops_path
    else
      @drop = Drop.find(session[:drop_id])    
      @meal = @drop.meals.new(meal_params)
    end     

    respond_to do |format|
      if @meal.save
        format.html { redirect_to meals_url, notice: 'Meal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meal }
      else
        format.html { render action: 'new' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to meals_url, notice: 'Meal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:start, :end, :remark, :spot_id, :amount, :is_paid, :key_person_id, :additional_person_id)
    end
end
