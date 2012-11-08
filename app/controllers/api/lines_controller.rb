class LinesController < ApplicationController
  load_and_authorize_resource

  # GET /lines
  # GET /lines.json
  def index
    @lines = Line.all
    render json => @lines
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
    @line = Line.find(params[:id])
    render json => @line
  end


end
