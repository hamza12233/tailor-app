class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :cloth_stuff, null: false
      t.string :urgency_type
      t.text :comment
      t.integer :status
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.references :proposal, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
