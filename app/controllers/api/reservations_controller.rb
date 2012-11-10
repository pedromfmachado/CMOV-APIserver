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

    departureLines = LineStation.where(:Station_id => departureStation_id).map { |x| x.Line_id }
    arrivalLines = LineStation.where(:Station_id => arrivalStation_id).map { |x| x.Line_id }

    line_id = (departureLines & arrivalLines).first

    puts "line: "
    puts line_id

    departureOrder = LineStation.where(:Station_id => departureStation_id, :Line_id => line_id).first.order
    arrivalOrder = LineStation.where(:Station_id => arrivalStation_id, :Line_id => line_id).first.order


    trips = Trip.where('Line_id = ? AND beginTime >= ?', line_id, actual_time).order('beginTime ASC')

    if trips.empty?
      trips = Trip.where('Line_id = ? AND beginTime >= ?', line_id, Time.gm(actual_time.year, actual_time.month, actual_time.day)).order('beginTime ASC')
    end

    trips.each do |trip|

      tripDepartureOrder = LineStation.where(:Station_id => trip.DepartureStation_id, :Line_id => trip.Line_id).first.order
      tripArrivalOrder = LineStation.where(:Station_id => trip.ArrivalStation_id, :Line_id => trip.Line_id).first.order

      if (tripDepartureOrder <= departureOrder && tripArrivalOrder >= arrivalOrder)

        actual_time = getStationTime(trip, departureStation_id)
        return trip

      end
 
    end

  end

  private 
  def getIntersections(line_id)

    stations = LineStation.where(:Line_id => line_id)

    intersections = Array.new

    stations.each do |station|

      linesPerStation = LineStation.where(:Station_id => station.Station_id).length

      if linesPerStation > 1

        intersections << station.Station_id

      end

    end

    return intersections

  end

  private
  def makeReservations(departureStation_id, arrivalStation_id, visited, result)

    departure = LineStation.where(:Station_id => departureStation_id)

    departure.each do |ls|

      arrival = LineStation.where(:Station_id => arrivalStation_id, :Line_id => ls.Line_id)

      if !arrival.blank?

        result << arrivalStation_id

      else

        intersections = getIntersections(ls.Line_id)
        
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

      if station_id == ls.Station_id
        return currentTime
      end

      timeElapsed = ls.distance.to_f / train.velocity
      currentTime = currentTime + timeElapsed.hours
    end

  end

end
