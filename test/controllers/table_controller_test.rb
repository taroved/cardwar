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

  test "should put turn" do
    put :turn, {id: 'c0dbbf2e-0fd7-47fa-94b7-c6acff06225c'}
    assert_response :success
  end

end
