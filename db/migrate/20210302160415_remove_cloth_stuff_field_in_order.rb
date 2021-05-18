class RemoveClothStuffFieldInOrder < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :cloth_stuff, :string
  end
end
