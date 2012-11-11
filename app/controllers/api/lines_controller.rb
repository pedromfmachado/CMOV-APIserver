class Api::LinesController < Api::BaseController

  # GET /lines
  # GET /lines.json
  def index
    @lines = Line.all
    render :json => @lines
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
    @line = Line.find(params[:id])
    @lineStations = LineStation.where( :line_id => params[:id])
    
    @stations = Array.new
    @lineStations.each do |ls|
      @stations << Station.find(ls.station_id)
    end
    
    render :json => { :line => @line, :stations => @stations }
  end


end
