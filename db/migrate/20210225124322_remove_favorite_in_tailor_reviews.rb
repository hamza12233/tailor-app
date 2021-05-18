class RemoveFavoriteInTailorReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :favorite
  end
end
