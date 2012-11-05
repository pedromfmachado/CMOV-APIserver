require 'test_helper'

class TripTypesControllerTest < ActionController::TestCase
  setup do
    @trip_type = trip_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trip_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip_type" do
    assert_difference('TripType.count') do
      post :create, trip_type: { name: @trip_type.name, price: @trip_type.price }
    end

    assert_redirected_to trip_type_path(assigns(:trip_type))
  end

  test "should show trip_type" do
    get :show, id: @trip_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip_type
    assert_response :success
  end

  test "should update trip_type" do
    put :update, id: @trip_type, trip_type: { name: @trip_type.name, price: @trip_type.price }
    assert_redirected_to trip_type_path(assigns(:trip_type))
  end

  test "should destroy trip_type" do
    assert_difference('TripType.count', -1) do
      delete :destroy, id: @trip_type
    end

    assert_redirected_to trip_types_path
  end
end
