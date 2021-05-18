class RemoveClothStuffFieldInProposal < ActiveRecord::Migration[6.0]
  def change
    remove_column :proposals, :cloth_stuff, :string
  end
end
