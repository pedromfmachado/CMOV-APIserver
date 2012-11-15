class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :generate_uuids
  respond_to :json

  private
  def generate_uuids

    Reservation.all.each do |r|

      rTrips = ReservationTrip.where(:reservation_id => r.id).order('time ASC')

      if rTrips.length != 0

        time = rTrips.first.time
        date = r.date.change(:hour => time.hour, :min => time.min)
        if (1.day.from_now >= date && r.uuid == nil)

          if(r.paid)
          
            uuid = UUIDTools::UUID.timestamp_create.to_s
            r.update_attributes(:uuid => uuid)

          else

            r.update_attributes(:canceled => true)

          end         

        end
      
      end

    end

  end
  
end

