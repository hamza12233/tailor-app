# frozen_string_literal: true

class Review < ApplicationRecord
  ATTRIBUTES_WHITELIST = %i[
    review
    rating
    user_id
    tailor_id
    comment
    favorite
    order_id
    id
  ].freeze

  validates :rating, presence: true
  validates :review,  uniqueness: { scope: [:order_id, :tailor_id]}


  belongs_to :user
  belongs_to :order

  scope :for_tailor, ->(id) { where(tailor_id: id) }

  def as_json
    super(
      include: {
        user: { only: %i[first_name last_name email] }
      })
  end
end
