class AddTailorToOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :tailor, foreign_key: {to_table: :users}, index: true, null: false
  end
end
