class Line < ActiveRecord::Base

  has_many :stations, :through => :line_stations
  has_many :trips

  attr_accessible :name

end
