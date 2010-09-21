require 'test_helper'

class ActorsControllerTest < ActionController::TestCase
  setup do
    @actor = actors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:actors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create actor" do
    assert_difference('Actor.count') do
      post :create, :actor => @actor.attributes
    end

    assert_redirected_to actor_path(assigns(:actor))
  end

  test "should show actor" do
    get :show, :id => @actor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @actor.to_param
    assert_response :success
  end

  test "should update actor" do
    put :update, :id => @actor.to_param, :actor => @actor.attributes
    assert_redirected_to actor_path(assigns(:actor))
  end

  test "should destroy actor" do
    assert_difference('Actor.count', -1) do
      delete :destroy, :id => @actor.to_param
    end

    assert_redirected_to actors_path
  end
end
