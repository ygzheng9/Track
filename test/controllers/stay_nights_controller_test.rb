require 'test_helper'

class StayNightsControllerTest < ActionController::TestCase
  setup do
    @stay_night = stay_nights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stay_nights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stay_night" do
    assert_difference('StayNight.count') do
      post :create, stay_night: { city_id: @stay_night.city_id, comment: @stay_night.comment, hotel_id: @stay_night.hotel_id, rate: @stay_night.rate, today: @stay_night.today }
    end

    assert_redirected_to stay_night_path(assigns(:stay_night))
  end

  test "should show stay_night" do
    get :show, id: @stay_night
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stay_night
    assert_response :success
  end

  test "should update stay_night" do
    patch :update, id: @stay_night, stay_night: { city_id: @stay_night.city_id, comment: @stay_night.comment, hotel_id: @stay_night.hotel_id, rate: @stay_night.rate, today: @stay_night.today }
    assert_redirected_to stay_night_path(assigns(:stay_night))
  end

  test "should destroy stay_night" do
    assert_difference('StayNight.count', -1) do
      delete :destroy, id: @stay_night
    end

    assert_redirected_to stay_nights_path
  end
end
