class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :uuid
      t.references :user
      t.references :arrivalStation
      t.references :departureStation
      t.boolean :canceled, :null => false, :default => "false"

      t.timestamps
    end
    add_index :reservations, :user_id
    add_index :reservations, :arrivalStation_id
    add_index :reservations, :departureStation_id
  end
end
