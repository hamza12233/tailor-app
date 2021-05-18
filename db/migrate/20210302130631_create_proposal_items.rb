class CreateProposalItems < ActiveRecord::Migration[6.0]
  def change
    create_table :proposal_items do |t|
      t.references :proposal, null: false, foreign_key: true, on_delete: :cascade
      t.references :category, null: false, foreign_key: true, on_delete: :cascade
      t.references :skill, null: false, foreign_key: true, on_delete: :cascade
      t.references :size_profile, foreign_key: true, null: true

      t.timestamps
    end
  end
end
