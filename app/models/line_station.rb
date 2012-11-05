class LineStation < ActiveRecord::Base
  belongs_to :line
  belongs_to :station
  attr_accessible :distance, :order
end
