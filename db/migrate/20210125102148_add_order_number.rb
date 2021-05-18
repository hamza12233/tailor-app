class AddOrderNumber < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :number, :integer, null: false, default: 0
    add_column :orders, :year, :integer, null: false, default: 0
    add_index :orders, %i[year number user_id], unique: true, name: 'order_year_number_uniqueness'

    add_column :proposals, :number, :integer, null: false, default: 0
    add_column :proposals, :year, :integer, null: false, default: 0
    add_index :proposals, %i[number year user_id], unique: true, name: 'proposal_year_number_uniqueness'
  end
end
