class Api::TripsController < Api::BaseController

  # GET /trips
  # GET /trips.json
  def index

    trips = Array.new
  
    

    Trip.all.each do |trip|

      trips << { :trip => trip, :time => trip.beginTime.strftime('%H:%M') }
    end
    
    render :json => trips

  end

  # GET /trips/1
  # GET /trips/1.json
  def show

    trip = Trip.find(params[:id])

    departureOrder = LineStation.find_by_station_id(trip.departureStation_id).order
    arrivalOrder = LineStation.find_by_station_id(trip.arrivalStation_id).order

    lineStations = LineStation.where(:order => departureOrder..arrivalOrder)
    lineStations = lineStations.where(:line_id => trip.line_id)
    if departureOrder < arrivalOrder
      lineStations.order('order ASC')
    else
      lineStations.order('order DESC')
    end

    times = Array.new
    currentTime = trip.beginTime
    lineStations.each do |ls|
      
      station = Station.find(ls.station_id)
      train = Train.find(trip.train_id)

      times << { :station => station, :time => currentTime.strftime('%H:%M') }

      timeElapsed = ls.distance.to_f / train.velocity
      currentTime = currentTime + timeElapsed.hours
    end

    render :json => { :trip => trip, :times => times }

  end

end
