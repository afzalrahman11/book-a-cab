class AddNamePhoneAndRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :phone, :string, null: false
    add_column :users, :role, :integer, default: 0
    add_index :users, :phone, unique: true
  end
end
