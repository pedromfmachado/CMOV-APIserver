class Api::StationsController < Api::BaseController

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.find(:all, :order => 'name ASC')

    render :json => @stations
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    @station = Station.find(params[:id])
    @lineStations = LineStation.where( :station_id => params[:id])
    
    @lines = Array.new
    @lineStations.each do |ls|
      @lines << Line.find(ls.line_id)
    end

    render :json => { :station => @station, :lines => @lines }
  end

end
