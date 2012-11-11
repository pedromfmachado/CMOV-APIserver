class ReservationTrip < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :trip
  belongs_to :departureStation
  belongs_to :arrivalStation
  attr_accessible :date, :trip_id, :reservation_id, :departureStation_id, :arrivalStation_id
end
