class CreateReservationTrips < ActiveRecord::Migration
  def change
    create_table :reservation_trips do |t|
      t.references :reservation
      t.references :trip
      t.references :departureStation
      t.references :arrivalStation
      t.datetime :time

      t.timestamps
    end
    add_index :reservation_trips, :reservation_id
    add_index :reservation_trips, :trip_id
    add_index :reservation_trips, :departureStation_id
    add_index :reservation_trips, :arrivalStation_id
  end
end
