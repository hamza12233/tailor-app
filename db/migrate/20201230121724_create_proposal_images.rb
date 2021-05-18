class CreateProposalImages < ActiveRecord::Migration[6.0]
  def change
    create_table :proposal_images do |t|
      t.references :proposal, null: false, foreign_key: true, on_delete: :cascade
      t.string :image

      t.timestamps
    end
  end
end
