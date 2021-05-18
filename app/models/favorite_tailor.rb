class FavoriteTailor < ApplicationRecord

  validates :user_id,  uniqueness: { scope: [:tailor_id]}

  belongs_to :tailor, class_name: 'User'
  belongs_to :user

end
