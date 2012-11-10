class ReservationTrip < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :trip
  # attr_accessible :title, :body
end
