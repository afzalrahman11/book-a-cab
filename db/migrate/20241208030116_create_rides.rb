class CreateRides < ActiveRecord::Migration[7.2]
  def change
    create_table :rides do |t|
      t.references :source_location, null: false, foreign_key: { to_table: :locations }
      t.references :destination_location, null: false, foreign_key: { to_table: :locations }
      t.integer :request_status, null: false, default: 0
      t.decimal :total_fare, precision: 10, scale: 2, null: false
      t.references :user, null: false, foreign_key: true
      t.references :cab, null: false, foreign_key: true

      t.timestamps
    end
  end
end
