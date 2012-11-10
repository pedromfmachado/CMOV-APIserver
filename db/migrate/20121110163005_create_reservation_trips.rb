class CreateReservationTrips < ActiveRecord::Migration
  def change
    create_table :reservation_trips do |t|
      t.references :reservation
      t.references :trip

      t.timestamps
    end
    add_index :reservation_trips, :reservation_id
    add_index :reservation_trips, :trip_id
  end
end
