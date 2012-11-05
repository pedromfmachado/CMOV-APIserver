class Train < ActiveRecord::Base

  has_many :trips
  attr_accessible :maxCapacity, :velocity

end
