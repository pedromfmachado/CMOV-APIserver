class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :generate_uuids
  respond_to :json

  private
  def generate_uuids

    Reservation.all.each do |r|

      rTrips = ReservationTrip.where(:reservation_id => r.id)

      if rTrips.length == 0
        break
      end

      time = rTrips.first.time
      if 1.day.from_now > time && r.uuid = nil
        
        uuid = UUIDTools::UUID.timestamp_create.to_s
        r.update_attributes(:uuid => uuid)

      end

    end

  end
  
end

