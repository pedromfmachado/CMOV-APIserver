class AddPaidToReservation < ActiveRecord::Migration
  def self.up
    change_table :reservations do |t|
      t.boolean :paid, :null => false, :default => false
    end
  end
  def self.down
    change_table :reservations do |t|
      t.remove :paid
    end
  end
end

