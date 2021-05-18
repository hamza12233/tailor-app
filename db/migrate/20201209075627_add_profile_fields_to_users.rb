class AddProfileFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string , null: false
    add_column :users, :last_name, :string , null: false
    add_column :users, :cnic, :string
    add_column :users, :dob, :datetime
    add_column :users, :phone_number, :string
    add_column :users, :whatsapp_number, :string
    add_column :users, :about_me, :string
    add_column :users, :gender, :integer
    add_column :users, :profile_img, :string
    add_column :users, :cover_img, :string
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :country, :string
  end
end
