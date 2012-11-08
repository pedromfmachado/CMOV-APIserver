class Api::RegistrationsController < Api::BaseController
  
  respond_to :json
  def create

    user = User.new(params[:user])
    if user.save
      render :json=>{ :success => true, :name => user.name,:auth_token => user.authentication_token, :email => user.email }
      return
    else
      warden.custom_failure!
      render :json=>{ :success => false, :errors => user.errors }
    end
  end
end
