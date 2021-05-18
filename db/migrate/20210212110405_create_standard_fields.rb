class CreateStandardFields < ActiveRecord::Migration[6.0]
  def change
    create_table :standard_fields do |t|
      t.integer :name, null: false, unique: true
      t.integer :gender, null: false, default: 0

      t.timestamps
    end
  end
end
