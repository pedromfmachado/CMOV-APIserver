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
    trip = makeReservations(6, 1, Array.new, result)

    result.reverse!

    render :json => result

  end

  private
  def getNextTrip(departureStation_id, arrivalStation_id, line_id, actual_time)

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

        #TODO: associate next trip to reservation
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

end
