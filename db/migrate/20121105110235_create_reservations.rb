class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :uuid
      t.references :User
      t.references :Trip
      t.references :ArrivalStation
      t.references :DepartureStation

      t.timestamps
    end
    add_index :reservations, :User_id
    add_index :reservations, :Trip_id
    add_index :reservations, :ArrivalStation_id
    add_index :reservations, :DepartureStation_id
  end
end
