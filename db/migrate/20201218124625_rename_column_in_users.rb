class RenameColumnInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :profile_img, :profile_photo
    rename_column :users, :cover_img, :cover_photo
  end
end
