class CreateLineStations < ActiveRecord::Migration
  def change
    create_table :line_stations do |t|
      t.integer :order
      t.integer :distance
      t.references :Line
      t.references :Station

      t.timestamps
    end
    add_index :line_stations, :Line_id
    add_index :line_stations, :Station_id
  end
end
