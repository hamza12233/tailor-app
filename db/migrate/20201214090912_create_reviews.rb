class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :user_id
      t.decimal :rating

      t.timestamps
    end
  end
end
