class CreateCatalogues < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogues do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, null: false
      t.references :category, foreign_key: true, index: true, null: false
      t.string :image, null: false, array: true

      t.timestamps
    end
  end
end
