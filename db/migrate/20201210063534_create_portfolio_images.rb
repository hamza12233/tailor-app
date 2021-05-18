class CreatePortfolioImages < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolio_images do |t|
      t.string :image

      t.references :portfolio, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
