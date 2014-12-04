require 'test_helper'

class TableControllerTest < ActionController::TestCase
  test "should post new" do
    post :new
    assert_response :success
  end

  test "should get index" do
    get :index, {id: 'c0dbbf2e-0fd7-47fa-94b7-c6acff06225c'}
    assert_response :success
  end

  test "should post turn" do
    post :turn, {id: 'c0dbbf2e-0fd7-47fa-94b7-c6acff06225c'}
    assert_response :success
  end

  test "finished turns to finish action" do
    post :turn, {id: '3fbeb2bf-2ade-45aa-8ce6-e18783c6e331'}
    assert_response :success
    assert_nil assigns(:turn)
  end

  test "not existed table" do
    get :turn, {id: 'not-existed-table-id'}
    assert_redirected_to  controller: "main"
  end
end
