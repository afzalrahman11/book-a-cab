class AddIsAvailableToCabs < ActiveRecord::Migration[7.2]
  def change
    add_column :cabs, :is_available, :boolean, default: true
  end
end
