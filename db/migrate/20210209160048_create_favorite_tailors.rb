class CreateFavoriteTailors < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_tailors do |t|
      t.references :tailor, foreign_key: { to_table: :users }, index: true, null: false
      t.references :user, null: false
      t.index [:user_id, :tailor_id], unique: true
      t.timestamps
    end
  end
end
