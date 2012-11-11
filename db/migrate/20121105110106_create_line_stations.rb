class CreateLineStations < ActiveRecord::Migration
  def change
    create_table :line_stations do |t|
      t.integer :order
      t.integer :distance
      t.references :line
      t.references :station

      t.timestamps
    end
    add_index :line_stations, :line_id
    add_index :line_stations, :station_id
  end
end
