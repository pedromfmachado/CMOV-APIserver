class LineStation < ActiveRecord::Base
  belongs_to :line
  belongs_to :station
  attr_accessible :distance, :order, :line_id, :station_id
end
