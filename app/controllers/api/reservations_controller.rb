class Api::ReservationsController < Api::BaseController

  # GET /reservations
  # GET /reservations.json
  def index
  
    user = User.find_by_authentication_token(params[:authentication_token])

    reservations = Reservation.find_all_by_user_id(user.id).find_all_by_canceled(false)

    result = Array.new
    reservations.each do |r|

      departureStation = Station.find(r.departureStation_id).name
      arrivalStation = Station.find(r.arrivalStation_id).name

      result << { :departure => departureStation, :arrival => arrivalStation, :date => r.date }

    end

    render :json => reservations

  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show

    user = User.find_by_authentication_token(params[:authentication_token])
    reservation = Reservation.find(params[:id])
    
    if user.id == reservation.user_id
      render :json => { reservation
    else
      render :json { :success => false }
    end

    

  end

  def cancel

    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(:canceled => true)

    render :json => { :success => true }

  end

  def create

    reservation = Reservation.new(params[:reservation])
    
	# still needs a little more testing
    # to allow a random 25% failures
    fail = [0,1,2,3]
    if fail.sample == 1 or fail.sample == 2 or fail.sample == 3
	
		if reservation.save

		  departureStation_id = params[:reservation][:departureStation_id].to_i
		  arrivalStation_id = params[:reservation][:arrivalStation_id].to_i
		  time = Time.parse(params[:time])
		  date = Date.parse(params[:reservation][:date])

		  result = Array.new

		  makeReservations( departureStation_id, arrivalStation_id, Array.new, result)
	  
		  result << departureStation_id.to_i

		  result.reverse!

		  for i in 0..(result.count-2)

			trip = getNextTrip(result[i], result[i+1], time)

			rt = ReservationTrip.new(:trip_id => trip.id, :reservation_id => reservation.id, :departureStation_id => reservation.departureStation_id,
									  :arrivalStation_id => reservation.arrivalStation_id, :date => reservation.date)
			
			rt.save

		  end

		  render :json =>  { :success => true }
		else
		  render :json => { :success => false }
		end
    else
      render :json => { :success => false }
    end

  end

  def get_trips

    departureStation_id = params[:departureStation_id].to_i
    arrivalStation_id = params[:arrivalStation_id].to_i
    time = Time.parse(params[:time])
    date = Date.parse(params[:date])

    result = Array.new
    trips_array = makeReservations( departureStation_id, arrivalStation_id, Array.new, result)

    result <<  departureStation_id.to_i

    result.reverse!

    trips = Array.new
    for i in 0..(result.count-2)

      trip = getNextTrip(result[i], result[i+1], time)

      if trip == nil
        puts 'entra'
        render :json => { :success => false }
        break
      end

      time = getStationTime(trip, result[i])

      departure = Station.find(result[i]).name
      arrival = Station.find(result[i+1]).name

      trips << { :trip => trip, :departure => departure, :arrival => arrival, :time => time.strftime('%H:%M') }

    end

    render :json =>  trips

  end

  private
  def getNextTrip(departureStation_id, arrivalStation_id, actual_time)

    departureLines = LineStation.where(:station_id => departureStation_id).map { |x| x.line_id }
    arrivalLines = LineStation.where(:station_id => arrivalStation_id).map { |x| x.line_id }

    line_id = (departureLines & arrivalLines).first

    departureOrder = LineStation.where(:station_id => departureStation_id, :line_id => line_id).first.order
    arrivalOrder = LineStation.where(:station_id => arrivalStation_id, :line_id => line_id).first.order

    trips = Trip.where('line_id = ? AND "beginTime" >= ?', line_id, actual_time).order('"beginTime" ASC')

    if trips.empty?
      trips = Trip.where('line_id = ? AND "beginTime" >= ?', line_id, Time.gm(actual_time.year, actual_time.month, actual_time.day)).order('"beginTime" ASC')
    end

    trips.each do |trip|

      tripDepartureOrder = LineStation.where(:station_id => trip.departureStation_id, :line_id => trip.line_id).first.order
      tripArrivalOrder = LineStation.where(:station_id => trip.arrivalStation_id, :line_id => trip.line_id).first.order

      if ((tripDepartureOrder <= tripArrivalOrder && departureOrder <= arrivalOrder)||
           tripDepartureOrder >= tripArrivalOrder && departureOrder >= arrivalOrder)

        #actual_time = getStationTime(trip, departureStation_id)
        return trip

      end
 
    end

    return nil

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

    return nil

  end


end
