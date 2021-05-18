class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.string :cloth_stuff, null: false
      t.string :urgency_type
      t.text :comment
      t.integer :status
      t.integer :category_ids, array: true, default: []
      t.integer :skill_ids, array: true, default: []
      t.references :user, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
