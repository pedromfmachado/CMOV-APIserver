class Station < ActiveRecord::Base

  has_many :lines, :through => :line_stations
  has_many :trips
  has_many :reservations
  attr_accessible :name

end
