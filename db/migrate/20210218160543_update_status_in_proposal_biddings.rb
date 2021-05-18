class UpdateStatusInProposalBiddings < ActiveRecord::Migration[6.0]
  def change
    change_column :proposal_biddings, :status, :integer, default: 0, null: false
  end
end
