require 'test_helper'

class MealDishesControllerTest < ActionController::TestCase
  setup do
    @meal_dish = meal_dishes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meal_dishes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meal_dish" do
    assert_difference('MealDish.count') do
      post :create, meal_dish: { amount: @meal_dish.amount, dish_id: @meal_dish.dish_id, meal_id: @meal_dish.meal_id, quantity: @meal_dish.quantity }
    end

    assert_redirected_to meal_dish_path(assigns(:meal_dish))
  end

  test "should show meal_dish" do
    get :show, id: @meal_dish
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meal_dish
    assert_response :success
  end

  test "should update meal_dish" do
    patch :update, id: @meal_dish, meal_dish: { amount: @meal_dish.amount, dish_id: @meal_dish.dish_id, meal_id: @meal_dish.meal_id, quantity: @meal_dish.quantity }
    assert_redirected_to meal_dish_path(assigns(:meal_dish))
  end

  test "should destroy meal_dish" do
    assert_difference('MealDish.count', -1) do
      delete :destroy, id: @meal_dish
    end

    assert_redirected_to meal_dishes_path
  end
end
