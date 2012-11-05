class Reservation < ActiveRecord::Base
  belongs_to :User
  belongs_to :Trip
  belongs_to :ArrivalStation
  belongs_to :DepartureStation
  attr_accessible :uuid
end
