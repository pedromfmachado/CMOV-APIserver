class TripType < ActiveRecord::Base
  
  has_many :trips
  attr_accessible :name, :price

end
