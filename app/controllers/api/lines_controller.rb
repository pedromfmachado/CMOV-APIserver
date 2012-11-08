class Api::LinesController < Api::BaseController
  load_and_authorize_resource

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
    @lineStations = LineStation.find(:line_id => params[:id])
    
    @lineStations.each do |ls|
      @stations << Stations.find(ls.station_id)
    end
  
    render :json => { :line => @line, :stations => @stations }
  end


end
