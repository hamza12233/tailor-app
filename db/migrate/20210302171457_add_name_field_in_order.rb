class AddNameFieldInOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :name, :string, null: false
  end
end
