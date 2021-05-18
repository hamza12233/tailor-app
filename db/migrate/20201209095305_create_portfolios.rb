class CreatePortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.string :title
      t.string :description

      t.references :user, foreign_key: true, on_delete: :cascade
      t.references :category, foreign_key: true, on_delete: :cascade
      
      t.timestamps
    end
  end
end
