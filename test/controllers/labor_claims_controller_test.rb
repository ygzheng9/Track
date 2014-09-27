require 'test_helper'

class LaborClaimsControllerTest < ActionController::TestCase
  setup do
    @labor_claim = labor_claims(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:labor_claims)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create labor_claim" do
    assert_difference('LaborClaim.count') do
      post :create, labor_claim: { comment: @labor_claim.comment, hours: @labor_claim.hours, project_id: @labor_claim.project_id, today: @labor_claim.today }
    end

    assert_redirected_to labor_claim_path(assigns(:labor_claim))
  end

  test "should show labor_claim" do
    get :show, id: @labor_claim
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @labor_claim
    assert_response :success
  end

  test "should update labor_claim" do
    patch :update, id: @labor_claim, labor_claim: { comment: @labor_claim.comment, hours: @labor_claim.hours, project_id: @labor_claim.project_id, today: @labor_claim.today }
    assert_redirected_to labor_claim_path(assigns(:labor_claim))
  end

  test "should destroy labor_claim" do
    assert_difference('LaborClaim.count', -1) do
      delete :destroy, id: @labor_claim
    end

    assert_redirected_to labor_claims_path
  end
end
