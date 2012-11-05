class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.datetime :beginTime
      t.references :TripType
      t.references :Train
      t.references :Line
      t.references :ArrivalStation
      t.references :DepartureStation

      t.timestamps
    end
    add_index :trips, :TripType_id
    add_index :trips, :Train_id
    add_index :trips, :Line_id
    add_index :trips, :ArrivalStation_id
    add_index :trips, :DepartureStation_id
  end
end
