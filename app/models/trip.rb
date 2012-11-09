class Trip < ActiveRecord::Base

  has_one :train
  has_one :trip_type
  has_one :line
  has_one :arrival_station
  has_one :departure_station
  has_many :reservations
  attr_accessible :beginTime, :TripType_id, :Train_id, :Line_id, :DepartureStation_id, :ArrivalStation_id


end
