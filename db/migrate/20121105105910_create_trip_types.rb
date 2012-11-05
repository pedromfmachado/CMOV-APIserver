class CreateTripTypes < ActiveRecord::Migration
  def change
    create_table :trip_types do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
