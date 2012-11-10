class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  belongs_to :station
  attr_accessible :uuid, :User_id, :Trip_id, :DepartureStation_id, :ArrivalStation_id
end
