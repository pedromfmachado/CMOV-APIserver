class TripTypesController < ApplicationController
  # GET /trip_types
  # GET /trip_types.json
  def index
    @trip_types = TripType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trip_types }
    end
  end

  # GET /trip_types/1
  # GET /trip_types/1.json
  def show
    @trip_type = TripType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip_type }
    end
  end

  # GET /trip_types/new
  # GET /trip_types/new.json
  def new
    @trip_type = TripType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip_type }
    end
  end

  # GET /trip_types/1/edit
  def edit
    @trip_type = TripType.find(params[:id])
  end

  # POST /trip_types
  # POST /trip_types.json
  def create
    @trip_type = TripType.new(params[:trip_type])

    respond_to do |format|
      if @trip_type.save
        format.html { redirect_to @trip_type, notice: 'Trip type was successfully created.' }
        format.json { render json: @trip_type, status: :created, location: @trip_type }
      else
        format.html { render action: "new" }
        format.json { render json: @trip_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trip_types/1
  # PUT /trip_types/1.json
  def update
    @trip_type = TripType.find(params[:id])

    respond_to do |format|
      if @trip_type.update_attributes(params[:trip_type])
        format.html { redirect_to @trip_type, notice: 'Trip type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trip_types/1
  # DELETE /trip_types/1.json
  def destroy
    @trip_type = TripType.find(params[:id])
    @trip_type.destroy

    respond_to do |format|
      format.html { redirect_to trip_types_url }
      format.json { head :no_content }
    end
  end
end
