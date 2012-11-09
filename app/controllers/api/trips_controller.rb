class Api::TripsController < Api::BaseController

  # GET /trips
  # GET /trips.json
  def index

    trips = Array.new
  
    

    Trip.all.each do |trip|
      trips << { :id => trip.id, :time => trip.beginTime.strftime('%H:%M'),
                 :departure_station => Station.find(trip.DepartureStation_id).name,
                 :arrival_station => Station.find(trip.ArrivalStation_id).name }
    end
    
    render :json => trips

  end

  # GET /trips/1
  # GET /trips/1.json
  def show

    trip = Trip.find(params[:id])

    departureOrder = LineStation.find_by_Station_id(trip.DepartureStation_id).order
    arrivalOrder = LineStation.find_by_Station_id(trip.ArrivalStation_id).order

    lineStations = LineStation.where(:order => departureOrder..arrivalOrder)
    lineStations = lineStations.where(:Line_id => trip.Line_id)
    if departureOrder < arrivalOrder
      lineStations.order('order ASC')
    else
      lineStations.order('order DESC')
    end

    times = Array.new
    currentTime = trip.beginTime
    lineStations.each do |ls|
      
      station = Station.find(ls.Station_id)
      train = Train.find(trip.Train_id)

      times << { :station => station, :time => currentTime.strftime('%H:%M') }

      timeElapsed = ls.distance.to_f / train.velocity
      currentTime = currentTime + timeElapsed.hours
    end

    render :json => { :trip => trip, :times => times }

  end

end
