require 'test_helper'

class PropagandasControllerTest < ActionController::TestCase
  setup do
    @propaganda = propagandas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:propagandas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create propaganda" do
    assert_difference('Propaganda.count') do
      post :create, :propaganda => @propaganda.attributes
    end

    assert_redirected_to propaganda_path(assigns(:propaganda))
  end

  test "should show propaganda" do
    get :show, :id => @propaganda.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @propaganda.to_param
    assert_response :success
  end

  test "should update propaganda" do
    put :update, :id => @propaganda.to_param, :propaganda => @propaganda.attributes
    assert_redirected_to propaganda_path(assigns(:propaganda))
  end

  test "should destroy propaganda" do
    assert_difference('Propaganda.count', -1) do
      delete :destroy, :id => @propaganda.to_param
    end

    assert_redirected_to propagandas_path
  end
end
