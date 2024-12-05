class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :locations, :latitude
    add_index :locations, :longitude
  end
end
