class LineStation < ActiveRecord::Base
  belongs_to :line
  belongs_to :station
  attr_accessible :distance, :order, :Line_id, :Station_id
end
