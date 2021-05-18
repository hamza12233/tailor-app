class CreateProfileSizings < ActiveRecord::Migration[6.0]
  def change
    create_table :size_profiles do |t|
      t.string :name, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
