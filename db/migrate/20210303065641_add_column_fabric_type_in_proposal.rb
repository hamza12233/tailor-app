class AddColumnFabricTypeInProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :fabric_type, :integer, null: false, default: 0
  end
end
