class Trip < ActiveRecord::Base
  belongs_to :TripType
  belongs_to :Train
  belongs_to :Line
  belongs_to :ArrivalStation
  belongs_to :DepartureStation
  attr_accessible :beginTime
end
