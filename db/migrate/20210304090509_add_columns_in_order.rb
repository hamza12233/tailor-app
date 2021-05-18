class AddColumnsInOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :due_date, :datetime, null: false
    add_column :orders, :bidding_price, :decimal, null: false
  end
end
