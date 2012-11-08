class Api::RegistrationsController < Api::BaseController
  
  respond_to :json
  def create

    user = User.new(params[:user])
    if user.save
      render :json=>{:success => true, :auth_token=>user.authentication_token, :email=>user.email}
      return
    else
      warden.custom_failure!
      render :json=>[user.errors, :success => false]
    end
  end
end
