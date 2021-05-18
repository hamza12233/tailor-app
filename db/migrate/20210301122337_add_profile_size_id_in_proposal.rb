class AddProfileSizeIdInProposal < ActiveRecord::Migration[6.0]
  def change
    add_reference :proposals, :size_profile, foreign_key: true, index: true, null: true
  end
end
