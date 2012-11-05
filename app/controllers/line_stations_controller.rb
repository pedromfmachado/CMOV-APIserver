class LineStationsController < ApplicationController
  load_and_authorize_resource

  # GET /line_stations
  # GET /line_stations.json
  def index
    @line_stations = LineStation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_stations }
    end
  end

  # GET /line_stations/1
  # GET /line_stations/1.json
  def show
    @line_station = LineStation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_station }
    end
  end

  # GET /line_stations/new
  # GET /line_stations/new.json
  def new
    @line_station = LineStation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_station }
    end
  end

  # GET /line_stations/1/edit
  def edit
    @line_station = LineStation.find(params[:id])
  end

  # POST /line_stations
  # POST /line_stations.json
  def create
    @line_station = LineStation.new(params[:line_station])

    respond_to do |format|
      if @line_station.save
        format.html { redirect_to @line_station, notice: 'Line station was successfully created.' }
        format.json { render json: @line_station, status: :created, location: @line_station }
      else
        format.html { render action: "new" }
        format.json { render json: @line_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_stations/1
  # PUT /line_stations/1.json
  def update
    @line_station = LineStation.find(params[:id])

    respond_to do |format|
      if @line_station.update_attributes(params[:line_station])
        format.html { redirect_to @line_station, notice: 'Line station was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_stations/1
  # DELETE /line_stations/1.json
  def destroy
    @line_station = LineStation.find(params[:id])
    @line_station.destroy

    respond_to do |format|
      format.html { redirect_to line_stations_url }
      format.json { head :no_content }
    end
  end
end
