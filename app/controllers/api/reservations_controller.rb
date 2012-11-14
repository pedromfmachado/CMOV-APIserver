class Api::ReservationsController < Api::BaseController

  # GET /reservations
  # GET /reservations.json
  def index

    user = User.find_by_authentication_token(params[:token])

    if user == nil

      render :json => []

    elsif user.role == 'inspector'

      if  params[:date] = nil
        render :json => []
        return
      end

      reservations = Reservation.where(:date => params[:date], :canceled => false)

      result = Array.new
      reservations.each do |r|

        reservationTrips = Array.new
        ReservationTrip.where(:reservation_id => r.id).each do |rt|

        departureStation = Station.find(r.departureStation_id).name
        arrivalStation = Station.find(r.arrivalStation_id).name
        reservationTrips << { :reservation_trip => rt, :departure => departureStation,
                              :arrival => arrivalStation, :time => rt.time.strftime('%H:%M') }            

        end

        departureStation = Station.find(r.departureStation_id).name
        arrivalStation = Station.find(r.arrivalStation_id).name

        result << { :reservation => r, :departure => departureStation, :arrival => arrivalStation, :reservation_trips => reservationTrips }

      end

      render :json => result

    else

      reservations = Reservation.where(:user_id => user.id, :canceled => false)

      result = Array.new
      reservations.each do |r|

        reservationTrips = Array.new
        ReservationTrip.where(:reservation_id => r.id).each do |rt|

        departureStation = Station.find(r.departureStation_id).name
        arrivalStation = Station.find(r.arrivalStation_id).name
        reservationTrips << { :reservation_trip => rt, :departure => departureStation,
                              :arrival => arrivalStation, :time => rt.time.strftime('%H:%M') }            

        end

        departureStation = Station.find(r.departureStation_id).name
        arrivalStation = Station.find(r.arrivalStation_id).name

        result << { :reservation => r, :departure => departureStation, :arrival => arrivalStation, :reservation_trips => reservationTrips }

      end

      render :json => result
    
    end

  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show

    user = User.find_by_authentication_token(params[:token])
    reservation = Reservation.find(params[:id])

    departureStation = Station.find(reservation.departureStation_id).name
    arrivalStation = Station.find(reservation.arrivalStation_id).name

    if user.id == reservation.user_id
      render :json => { :reservation => reservation, :departure => departureStation, :arrival => arrivalStation }
    else
      render :json => { :success => false }
    end

    

  end

  #confirm reservation
  def confirm

    user = User.find_by_authentication_token(params[:token])
    
    if user.role != 'inspector'

      render :json => { :success => false, :errors => ["User" => "has to be an inspector"] }
      return

    end

    reservation = Reservation.find_by_uuid(params[:uuid])

    if reservation == nil
      render :json => { :success => false, :errors => ["Reservation" => "does not exist"] }
    end

    rTrips = ReservationTrip.where(:reservation_id => reservation.id, :trip_id => params[:trip_id])
    
    if rTrips.count > 0
      render :json => { :success => true, :trip => reservation }
    else
      render :json => { :success => false, :errors => ["Trip" => "is not part of indicated reservation"] }    
    end

  end


  # cancel reservation
  def cancel

    user = User.find_by_authentication_token(params[:token])
    reservation = Reservation.find(params[:id])

    if user.id != reservation.user_id

      render :json => { :success => false, :errors => ["User" => "does not correspond to reservation"] }
      return

    end

    if reservation.update_attributes(:canceled => true)

      render :json => { :success => true }

    else

      render :json => { :success => false }      
      
    end

  end

  # create reservation
  def create

    user = User.find_by_authentication_token(params[:token])

    if user == nil
    
      render :json => { :sucess => false, :errors => ["User" => "is not valid"] }
    
    elsif params[:reservation][:user_id] != user.id.to_s
  
      render :json => { :sucess => false, :errors => ["Authentication token" => "is not valid"] }      

    else
   
      reservation = Reservation.new(params[:reservation])
      
      # to allow a random 10% failures
      fail = (0..9).to_a
      if fail.sample != 9

		      if reservation.save

		        departureStation_id = params[:reservation][:departureStation_id].to_i
		        arrivalStation_id = params[:reservation][:arrivalStation_id].to_i
		        time = Time.parse(params[:time]).change(:month => 1, :day => 1, :year => 2000)
		        date = Date.parse(params[:reservation][:date])

		        result = Array.new

		        makeReservations( departureStation_id, arrivalStation_id, Array.new, result)
	        
		        result << departureStation_id.to_i

		        result.reverse!

		        for i in 0..(result.count-2)

			        trip = getNextTrip(result[i], result[i+1], time, date)

              if trip == nil
                render :json => { :success => false, :errors => ["Trip" => " is not valid"]}
                return
              end

              lotation = get_trip_lotation(trip, result[i], date)

              if lotation <= 0
                render :json => { :success => false, :errors => ["Trip" => "is full"]}
                return
              end

              time = getStationTime(trip, result[i])

			        rt = ReservationTrip.new(:trip_id => trip.id, :reservation_id => reservation.id, :departureStation_id => result[i],
									          :arrivalStation_id => result[i+1], :time => time.strftime('%H:%M'))
			
			        rt.save

		        end

		        render :json =>  { :success => true }
		      else
		        render :json => { :success => false, :errors => ["Reservaion" => "error saving"] }
		      end
        else
          render :json => { :success => false, :errors => ["Credit card provider" => "rejected the transaction"]}
        end
    
    
    end

  end

  def get_trips

    departureStation_id = params[:departureStation_id].to_i
    arrivalStation_id = params[:arrivalStation_id].to_i
    date = Date.parse(params[:date])
    time = Time.parse(params[:time]).change(:month => 1, :day => 1, :year => 2000)

    # calculating path
    result = Array.new
    makeReservations( departureStation_id, arrivalStation_id, Array.new, result)
    # adding first station of reservation to array
    result <<  departureStation_id.to_i
    result.reverse!

    trips = Array.new
    for i in 0..(result.count-2)

      trip = getNextTrip(result[i], result[i+1], time, date)

      if trip == nil
        render :json => { :success => false, :error => ["Trip" => "There are no trips available"]}
        return
      end

      lotation = get_trip_lotation(trip, result[i],date)
      
      # if there the trip is full
      if lotation <= 0
        render :json => { :success => false, :error => ["Trip" => "All trips are full"]}
        return
      end      

      # time in the departure station of segment
      time = getStationTime(trip, result[i])

      departure = Station.find(result[i]).name
      arrival = Station.find(result[i+1]).name

      trips << { :trip => trip, :departure => departure, :arrival => arrival, :lotation => lotation, :time => time.strftime('%H:%M') }

    end

    render :json => { :success => true, :trips => trips }

  end

  private
  def getNextTrip(departureStation_id, arrivalStation_id, actual_time, date)

    # all lines to which a station belongs
    departureLines = LineStation.where(:station_id => departureStation_id).map { |x| x.line_id }
    arrivalLines = LineStation.where(:station_id => arrivalStation_id).map { |x| x.line_id }

    # line that belongs to both of the stations
    line_id = (departureLines & arrivalLines).first

    # order of the stations in line
    departureOrder = LineStation.where(:station_id => departureStation_id, :line_id => line_id).first.order
    arrivalOrder = LineStation.where(:station_id => arrivalStation_id, :line_id => line_id).first.order

    # all the next trips
    trips = Trip.where('line_id = ? AND "beginTime" >= ?', line_id, actual_time).order('"beginTime" ASC')
    
    if trips.empty?
      trips = Trip.where('line_id = ? AND "beginTime" >= ?', line_id, Time.gm(actual_time.year, actual_time.month, actual_time.day)).order('"beginTime" ASC')
    end

    trips.each do |trip|

      # order of arrival and departure stations of the trip
      tripDepartureOrder = LineStation.where(:station_id => trip.departureStation_id, :line_id => trip.line_id).first.order
      tripArrivalOrder = LineStation.where(:station_id => trip.arrivalStation_id, :line_id => trip.line_id).first.order

      # if stations are in the correct order
      if (((tripDepartureOrder <= tripArrivalOrder && departureOrder <= arrivalOrder)||
           (tripDepartureOrder >= tripArrivalOrder && departureOrder >= arrivalOrder)) &&
           get_trip_lotation(trip,departureOrder,date))

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

  def get_trip_lotation(trip, departureStation_id, date)

    count = 0

    reservations = Reservation.where(:date => date)
    train = Train.find(trip.train_id)

    reservations.each do |r|

      reservationTrips = ReservationTrip.where(:reservation_id => r.id, :trip_id => trip.id)

      reservationTrips.each do |rt|

        departureTrip = LineStation.where(:line_id => trip.line_id, :station_id => departureStation_id).first

        departure = LineStation.where(:line_id => trip.line_id, :station_id => rt.departureStation_id).first
        arrival = LineStation.where(:line_id => trip.line_id, :station_id => rt.arrivalStation_id).first

        if (departureTrip == nil || departure == nil || arrival == nil)
          next
        end

        if (departure.order <= departureTrip.order && arrival.order > departureTrip.order)

          count += 1

        end

      end

    end

    return (train.maxCapacity - count)

  end


end
