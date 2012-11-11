class Trip < ActiveRecord::Base

  has_one :train
  has_one :trip_type
  has_one :line
  has_one :arrival_station
  has_one :departure_station
  has_many :reservations
  attr_accessible :beginTime, :tripType_id, :train_id, :line_id, :departureStation_id, :arrivalStation_id


end
