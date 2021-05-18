class CreateOrderSizingFields < ActiveRecord::Migration[6.0]
  def change
    create_table :order_item_size_profile_fields do |t|
      t.integer :value, default: 0, null: false
      t.references :order_item_size_profile, null: false, index: { name: :order_iteem_prof_index }
      t.references :standard_field, null: false
      t.references :user, null: false
      t.index %i[user_id standard_field_id order_item_size_profile_id], unique: true, name: 'standard_orde_items_filed_unique'

      t.timestamps
    end
  end
end
