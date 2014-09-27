require 'test_helper'

class WorkingLocationsControllerTest < ActionController::TestCase
  setup do
    @working_location = working_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:working_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create working_location" do
    assert_difference('WorkingLocation.count') do
      post :create, working_location: { Taxi: @working_location.Taxi, city_id: @working_location.city_id, comment: @working_location.comment, site_id: @working_location.site_id, today: @working_location.today }
    end

    assert_redirected_to working_location_path(assigns(:working_location))
  end

  test "should show working_location" do
    get :show, id: @working_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @working_location
    assert_response :success
  end

  test "should update working_location" do
    patch :update, id: @working_location, working_location: { Taxi: @working_location.Taxi, city_id: @working_location.city_id, comment: @working_location.comment, site_id: @working_location.site_id, today: @working_location.today }
    assert_redirected_to working_location_path(assigns(:working_location))
  end

  test "should destroy working_location" do
    assert_difference('WorkingLocation.count', -1) do
      delete :destroy, id: @working_location
    end

    assert_redirected_to working_locations_path
  end
end
