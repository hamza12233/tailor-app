# frozen_string_literal: true

class SizeProfile < ApplicationRecord
  ATTRIBUTES_WHITELIST = [
    :name,
    :id,
    :gender,
    { size_profile_fields_attributes: SizeProfileField::ATTRIBUTES_WHITELIST }
  ].freeze

  GENDER = { men: 0,
             women: 1 }.freeze

  enum gender: GENDER

  has_many :size_profile_fields, dependent: :destroy
  has_one :proposal
  has_one :order_item
  belongs_to :user

  validates :name, presence: true

  accepts_nested_attributes_for :size_profile_fields, allow_destroy: true

  def as_json
    super(
      {
        include: {
          size_profile_fields: {
            include: {
              standard_field: {}
            }
          }
        }
      }
    )
  end
end
