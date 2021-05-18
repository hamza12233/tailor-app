class AddTailorIdInOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :tailor, foreign_key: { to_table: :users }, index: true
  end
end
