class AddNameFieldInProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :name, :string
  end
end
