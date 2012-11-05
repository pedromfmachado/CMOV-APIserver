class Trip < ActiveRecord::Base

  has_one :train
  has_one :trip_type
  has_one :line
  belongs_to :station
  has_many :reservations
  attr_accessible :beginTime

end
