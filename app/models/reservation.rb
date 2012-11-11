class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :station
  attr_accessible :uuid, :user_id, :departureStation_id, :arrivalStation_id, :date, :canceled
end
