class AddTailorIdInReview < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :tailor, foreign_key: { to_table: :users }, index: true
  end
end
