class LineStation < ActiveRecord::Base
  belongs_to :Line
  belongs_to :Station
  attr_accessible :distance, :order
end
