class MealDishesController < ApplicationController
  before_action :set_meal_dish, only: [:show, :edit, :update, :destroy]

  # GET /meal_dishes
  # GET /meal_dishes.json
  def index
    if session[:meal_id].nil?
      redirect_to meals_path
    else
      @meal = Meal.find(session[:meal_id])    
      @meal_dishes = @meal.meal_dishes
    end     
  end

  def index_nested
    if params[:meal_id].nil? and session[:meal_id].nil?
      redirect_to meals_path
    else
      session[:meal_id] = params[:meal_id] unless params[:meal_id].nil?
      @meal = Meal.find(session[:meal_id])    
      @meal_dishes = @meal.meal_dishes
    end   

    render "index" 
  end 

  # GET /meal_dishes/1
  # GET /meal_dishes/1.json
  def show
  end

  # GET /meal_dishes/new
  def new
    if session[:meal_id].nil?
      redirect_to meals_path
    else
      @meal = Meal.find(session[:meal_id])    
      @meal_dish = @meal.meal_dishes.new
    end      
  end

  # GET /meal_dishes/1/edit
  def edit
  end

  # POST /meal_dishes
  # POST /meal_dishes.json
  def create
    if session[:meal_id].nil?
      redirect_to meals_path
    else
      @meal = Meal.find(session[:meal_id])    
      @meal_dish = @meal.meal_dishes.new(meal_dish_params)
    end       

    respond_to do |format|
      if @meal_dish.save
        format.html { redirect_to meal_dishes_url, notice: 'Meal dish was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meal_dish }
      else
        format.html { render action: 'new' }
        format.json { render json: @meal_dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meal_dishes/1
  # PATCH/PUT /meal_dishes/1.json
  def update
    respond_to do |format|
      if @meal_dish.update(meal_dish_params)
        format.html { redirect_to meal_dishes_url, notice: 'Meal dish was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meal_dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_dishes/1
  # DELETE /meal_dishes/1.json
  def destroy
    @meal_dish.destroy
    respond_to do |format|
      format.html { redirect_to meal_dishes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_dish
      @meal_dish = MealDish.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_dish_params
      params.require(:meal_dish).permit(:dish_id, :amount, :quantity, :remark)
    end
end
