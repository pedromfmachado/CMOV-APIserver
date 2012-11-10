class ReservationTripsController < ApplicationController
  # GET /reservation_trips
  # GET /reservation_trips.json
  def index
    @reservation_trips = ReservationTrip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservation_trips }
    end
  end

  # GET /reservation_trips/1
  # GET /reservation_trips/1.json
  def show
    @reservation_trip = ReservationTrip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation_trip }
    end
  end

  # GET /reservation_trips/new
  # GET /reservation_trips/new.json
  def new
    @reservation_trip = ReservationTrip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation_trip }
    end
  end

  # GET /reservation_trips/1/edit
  def edit
    @reservation_trip = ReservationTrip.find(params[:id])
  end

  # POST /reservation_trips
  # POST /reservation_trips.json
  def create
    @reservation_trip = ReservationTrip.new(params[:reservation_trip])

    respond_to do |format|
      if @reservation_trip.save
        format.html { redirect_to @reservation_trip, notice: 'Reservation trip was successfully created.' }
        format.json { render json: @reservation_trip, status: :created, location: @reservation_trip }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservation_trips/1
  # PUT /reservation_trips/1.json
  def update
    @reservation_trip = ReservationTrip.find(params[:id])

    respond_to do |format|
      if @reservation_trip.update_attributes(params[:reservation_trip])
        format.html { redirect_to @reservation_trip, notice: 'Reservation trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservation_trips/1
  # DELETE /reservation_trips/1.json
  def destroy
    @reservation_trip = ReservationTrip.find(params[:id])
    @reservation_trip.destroy

    respond_to do |format|
      format.html { redirect_to reservation_trips_url }
      format.json { head :no_content }
    end
  end
end
