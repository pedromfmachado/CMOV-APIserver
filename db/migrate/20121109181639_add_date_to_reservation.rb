class AddDateToReservation < ActiveRecord::Migration
  def self.up
    change_table :reservations do |t|
      t.date :date
    end
  end
  def self.down
    t.date :date
  end
end
