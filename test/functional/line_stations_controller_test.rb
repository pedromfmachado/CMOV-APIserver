require 'test_helper'

class LineStationsControllerTest < ActionController::TestCase
  setup do
    @line_station = line_stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_station" do
    assert_difference('LineStation.count') do
      post :create, line_station: { distance: @line_station.distance, order: @line_station.order }
    end

    assert_redirected_to line_station_path(assigns(:line_station))
  end

  test "should show line_station" do
    get :show, id: @line_station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_station
    assert_response :success
  end

  test "should update line_station" do
    put :update, id: @line_station, line_station: { distance: @line_station.distance, order: @line_station.order }
    assert_redirected_to line_station_path(assigns(:line_station))
  end

  test "should destroy line_station" do
    assert_difference('LineStation.count', -1) do
      delete :destroy, id: @line_station
    end

    assert_redirected_to line_stations_path
  end
end
