class CreateOrderSizings < ActiveRecord::Migration[6.0]
  def change
    create_table :order_item_size_profiles do |t|
      t.string :name, null: false
      t.references :user, null: false
      t.references :order_item, null: false

      t.timestamps
    end
  end
end
