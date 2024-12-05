class CreateCabs < ActiveRecord::Migration[7.2]
  def change
    create_table :cabs do |t|
      t.string :model, null: false
      t.string :vehicle_number, null: false
      t.integer :category, null: false, default: 0
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
