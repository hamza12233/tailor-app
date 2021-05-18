# frozen_string_literal: true

class OrderItem < ApplicationRecord
  ATTRIBUTES_WHITELIST = %i[
    id
    order_id
    category_id
    skill_id
    user_id
  ].freeze

  has_one :order_item_size_profile

  belongs_to :order
  belongs_to :category
  belongs_to :skill
  belongs_to :user
  belongs_to :tailor, class_name: 'User', foreign_key: :tailor_id
  belongs_to :size_profile, optional: true

  def as_json
    super(
      {
        include: { order_item_size_profile: {},
                   size_profile: {} }
      }
    )
  end

  def toggle_size_profile(size_profile_id)
    return false unless can_assign_size_profile?

    if size_profile_id.present?
      size_profile = SizeProfile.find(size_profile_id.to_i)
      update(size_profile: size_profile)
    else
      update(size_profile: nil)
    end
  end

  def can_assign_size_profile?
    return true if order_item_size_profile.blank?

    self.errors.add(:size_profile_id, 'Order Item Size profile is already attached.')

    false
  end
end
