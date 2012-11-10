class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :uuid
      t.references :User
      t.references :ArrivalStation
      t.references :DepartureStation
      t.boolean :canceled, :null => false, :default => "false"

      t.timestamps
    end
    add_index :reservations, :User_id
    add_index :reservations, :ArrivalStation_id
    add_index :reservations, :DepartureStation_id
  end
end
