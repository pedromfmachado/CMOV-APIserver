class Api::LinesController < Api::BaseController

  # GET /lines
  # GET /lines.json
  def index

    lines = Array.new
    Line.all.each do |l|

      lineStations = LineStation.where(:line_id => l.id)

      lines << { :line => l, :lineStations => lineStations }

    end

    render :json => lines
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
