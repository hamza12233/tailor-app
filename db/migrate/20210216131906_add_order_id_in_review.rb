class AddOrderIdInReview < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :order, foreign_key: true, null: false
  end
end
