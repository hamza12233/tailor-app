# frozen_string_literal: true

class OrderItemSizeProfile < ApplicationRecord
  ATTRIBUTES_WHITELIST = [
    :name,
    :id,
    :gender,
    :user_id,
    { order_item_size_profile_fields_attributes: OrderItemSizeProfileField::ATTRIBUTES_WHITELIST }
  ].freeze

  GENDER = { men: 0,
             women: 1 }.freeze

  enum gender: GENDER

  has_many :order_item_size_profile_fields, dependent: :destroy
  belongs_to :user
  belongs_to :order_item

  validates :name, presence: true

  accepts_nested_attributes_for :order_item_size_profile_fields, allow_destroy: true

  def as_json
    super(
      {
        include: {
          order_item_size_profile_fields: {
            include: {
              standard_field: {}
            }
          }
        }
      }
    )
  end
end
