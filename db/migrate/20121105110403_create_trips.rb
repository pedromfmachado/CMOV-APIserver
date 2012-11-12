class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.time :beginTime
      t.references :tripType
      t.references :train
      t.references :line
      t.references :arrivalStation
      t.references :departureStation

      t.timestamps
    end
    add_index :trips, :tripType_id
    add_index :trips, :train_id
    add_index :trips, :line_id
    add_index :trips, :arrivalStation_id
    add_index :trips, :departureStation_id
  end
end
