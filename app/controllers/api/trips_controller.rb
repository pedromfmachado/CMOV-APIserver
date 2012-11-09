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

    

    lineStations = LineStation.where(:order => (trip.DepartureStation_)..(trip.ArrivalStation.order))
    if trip.DepartureStation.order < trip.ArrivalStation.order
      lineStations.order('order ASC')
    else
      lineStations.order('order DESC')
    end

    times = Array.new
    actualtime = trip.beginTime
    lineStations.each do |ls|
      
      station = Station.find(ls.Station_id)
      train = Train.find(trip.Train_id)

      timeElapsed = ls.distance.to_f / train.velocity

      actualtime + actualtime + timeElapsed.hours

      times << { :station => station } #TODO: add time to json
    end

    render :json => { :trip => trip, :times => times }

  end

end
