class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true, on_delete: :cascade
      t.references :category, null: false, foreign_key: true, on_delete: :cascade
      t.references :skill, null: false, foreign_key: true, on_delete: :cascade
      t.references :user, null:false, foreign_key: true, on_delete: :cascade
      
      t.timestamps
    end
  end
end
