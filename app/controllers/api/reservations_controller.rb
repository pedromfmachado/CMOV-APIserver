class Api::ReservationsController < Api::BaseController

  # GET /trips
  # GET /trips.json
  def index

    reservations = Reservation.all    

    render :json => reservations

  end

  # GET /trips/1
  # GET /trips/1.json
  def show

    reservation = Reservation.find(params[:id])

    render :json => reservation

  end

  def create

    result = Array.new
    trip = makeReservations(params[:departureStation_id].to_i, params[:arrivalStation_id].to_i, Array.new, result)

    result << params[:departureStation_id].to_i

    result.reverse!

    trips = Array.new
    actual_time = Time.now
    for i in 0..(result.count-2)

      trips << { :trip => getNextTrip(result[i], result[i+1], actual_time), :intersection => result[i],
                :time => actual_time }

    end

    render :json =>  { :trips => trips }

  end

  private
  def getNextTrip(departureStation_id, arrivalStation_id, actual_time)

    departureLines = LineStation.where(:station_id => departureStation_id).map { |x| x.line_id }
    arrivalLines = LineStation.where(:station_id => arrivalStation_id).map { |x| x.line_id }

    line_id = (departureLines & arrivalLines).first


    departureOrder = LineStation.where(:station_id => departureStation_id, :line_id => line_id).first.order
    arrivalOrder = LineStation.where(:station_id => arrivalStation_id, :line_id => line_id).first.order


    trips = Trip.where('line_id = ? AND \"beginTime\" >= ?', line_id, actual_time).order('beginTime ASC')

    if trips.empty?
      trips = Trip.where('line_id = ? AND \"beginTime\" >= ?', line_id, Time.gm(actual_time.year, actual_time.month, actual_time.day)).order('beginTime ASC')
    end

    trips.each do |trip|

      tripDepartureOrder = LineStation.where(:station_id => trip.departureStation_id, :line_id => trip.line_id).first.order
      tripArrivalOrder = LineStation.where(:station_id => trip.arrivalStation_id, :line_id => trip.line_id).first.order

      if (tripDepartureOrder <= departureOrder && tripArrivalOrder >= arrivalOrder)

        actual_time = getStationTime(trip, departureStation_id)
        return trip

      end
 
    end

  end

  private 
  def getIntersections(line_id)

    stations = LineStation.where(:line_id => line_id)

    intersections = Array.new

    stations.each do |station|

      linesPerStation = LineStation.where(:station_id => station.station_id).length

      if linesPerStation > 1

        intersections << station.station_id

      end

    end

    return intersections

  end

  private
  def makeReservations(departureStation_id, arrivalStation_id, visited, result)

    departure = LineStation.where(:station_id => departureStation_id)

    departure.each do |ls|

      arrival = LineStation.where(:station_id => arrivalStation_id, :line_id => ls.line_id)

      if !arrival.blank?

        result << arrivalStation_id

      else

        intersections = getIntersections(ls.line_id)
        
        intersections.each do |i|
          
          if !visited.include? i

            visited << i

            makeReservations(i, arrivalStation_id, visited, result)
            
            if !result.blank?

              result << i

            end

          end

        end

      end

    end

  end

  private
  def getStationTime(trip, station_id)

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

      if station_id == ls.station_id
        return currentTime
      end

      timeElapsed = ls.distance.to_f / train.velocity
      currentTime = currentTime + timeElapsed.hours
    end

  end

end