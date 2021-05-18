class CreateOrderImages < ActiveRecord::Migration[6.0]
  def change
    create_table :order_images do |t|
      t.references :order, null: false, foreign_key: true, on_delete: :cascade
      t.string :image

      t.timestamps
    end
  end
end
