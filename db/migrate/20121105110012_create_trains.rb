class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.integer :maxCapacity
      t.float :velocity

      t.timestamps
    end
  end
end
