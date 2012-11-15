class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :generate_uuids
  respond_to :json

  private
  def generate_uuids

    Reservation.all.each do |r|

      rTrips = ReservationTrip.where(:reservation_id => r.id).order('time ASC')

      if rTrips.length != 0

        date = r.date        
        time = rTrips.first.time.change(:year => date.year, :month => date.month, :day => date.day)
        puts "time #{1.day.from_now >= time} trip => #{r.id}"
        
        if (1.day.from_now >= time)

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

