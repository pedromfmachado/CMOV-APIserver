class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  belongs_to :station
  attr_accessible :uuid, :user_id, :trip_id, :departureStation_id, :arrivalStation_id, :date
end
