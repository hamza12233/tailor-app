class AddColumnFabricTypeInOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :fabric_type, :integer, null: false, default: 0
  end
end
