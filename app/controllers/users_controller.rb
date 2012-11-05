class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /trips
  # GET /trips.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def promote
    User.find(params[:id]).promote
    redirect_to users_path
  end

  def demote
    User.find(params[:id]).demote
    redirect_to users_path
  end

end
