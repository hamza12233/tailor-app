class CreateProfileSizingFields < ActiveRecord::Migration[6.0]
  def change
    create_table :size_profile_fields do |t|
      t.integer :value, default: 0, null: false
      t.references :size_profile, null: false
      t.references :standard_field, null: false
      t.references :user, null: false
      t.index %i[user_id standard_field_id size_profile_id], unique: true,name: 'standard_user_profile_fileds_uniqueness'

      t.timestamps
    end
  end
end
