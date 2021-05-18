class AddsizeOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :size_profile, foreign_key: true, null: true
    add_column :order_item_size_profiles, :gender, :integer, null: false, default: 0
    add_column :size_profiles, :gender, :integer, null: false, default: 0
  end
end
