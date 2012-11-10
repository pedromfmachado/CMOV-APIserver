require 'test_helper'

class ReservationTripsControllerTest < ActionController::TestCase
  setup do
    @reservation_trip = reservation_trips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reservation_trips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reservation_trip" do
    assert_difference('ReservationTrip.count') do
      post :create, reservation_trip: {  }
    end

    assert_redirected_to reservation_trip_path(assigns(:reservation_trip))
  end

  test "should show reservation_trip" do
    get :show, id: @reservation_trip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reservation_trip
    assert_response :success
  end

  test "should update reservation_trip" do
    put :update, id: @reservation_trip, reservation_trip: {  }
    assert_redirected_to reservation_trip_path(assigns(:reservation_trip))
  end

  test "should destroy reservation_trip" do
    assert_difference('ReservationTrip.count', -1) do
      delete :destroy, id: @reservation_trip
    end

    assert_redirected_to reservation_trips_path
  end
end
