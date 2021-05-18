class AddUnitInStandardField < ActiveRecord::Migration[6.0]
  def change
    add_column :standard_fields, :unit, :integer, default: 0, null: false
  end
end
