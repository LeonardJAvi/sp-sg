require 'test_helper'

class StackStatesControllerTest < ActionController::TestCase
  setup do
    @stack_state = stack_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stack_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stack_state" do
    assert_difference('StackState.count') do
      post :create, stack_state: { name: @stack_state.name }
    end

    assert_redirected_to stack_state_path(assigns(:stack_state))
  end

  test "should show stack_state" do
    get :show, id: @stack_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stack_state
    assert_response :success
  end

  test "should update stack_state" do
    patch :update, id: @stack_state, stack_state: { name: @stack_state.name }
    assert_redirected_to stack_state_path(assigns(:stack_state))
  end

  test "should destroy stack_state" do
    assert_difference('StackState.count', -1) do
      delete :destroy, id: @stack_state
    end

    assert_redirected_to stack_states_path
  end
end
