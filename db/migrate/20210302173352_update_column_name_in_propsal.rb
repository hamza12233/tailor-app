class UpdateColumnNameInPropsal < ActiveRecord::Migration[6.0]
  def change
    change_column :proposals, :name, :string, null: false
  end
end
