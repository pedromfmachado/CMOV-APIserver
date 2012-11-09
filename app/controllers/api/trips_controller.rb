class Api::TripsController < Api::BaseController

  # GET /trips
  # GET /trips.json
  def index

    trips = Trip.all
    render :json => trips 

  end

  # GET /trips/1
  # GET /trips/1.json
  def show

    trip = Trip.find(params[:id])

    departureOrder = LineStation.find_by_Line_id(trip.DepartureStation_id).order
    arrivalOrder = LineStation.find_by_Line_id(trip.DepartureStation_id).order

    lineStations = LineStation.where(:order => departureOrder..arrivalOrder)
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

      timeElapsed = ls.distance.to_f / train.velocity

      currentTime = currentTime + timeElapsed.hours

      times << { :station => station, :time => currentTime }
    end

    render :json => { :trip => trip, :times => times }

  end

end
