class AddColumnFavoriteToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :favorite, :boolean, default: false
  end
end
