class CreateProposalBiddings < ActiveRecord::Migration[6.0]
  def change
    create_table :proposal_biddings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposal, null: false, foreign_key: true
      t.integer :status
      t.decimal :bidding_price
      t.datetime :due_date
      t.boolean :invite_only, null:false, default:true

      t.timestamps
    end
  end
end
