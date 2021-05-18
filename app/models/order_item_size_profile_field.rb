# frozen_string_literal: true

class OrderItemSizeProfileField < ApplicationRecord
  ATTRIBUTES_WHITELIST = %i[
    id
    value
    user_id
    standard_field_id
    _destroy
  ].freeze

  belongs_to :order_item_size_profile
  belongs_to :standard_field
  belongs_to :user

  validates :value, presence: true
  validates :user,  uniqueness: { scope: %i[standard_field_id order_item_size_profile_id] }
end
