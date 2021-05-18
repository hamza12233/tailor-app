# frozen_string_literal: true

class Order < ApplicationRecord
  STATUS = {
    in_progress: 0,
    completed: 1,
    dispatched: 2
  }.freeze

  FABRIC_TYPE = {
    fabric: 0,
    inspiration: 1
  }.freeze

  ATTRIBUTES_WHITELIST = [
    :name,
    :urgency_type,
    :comment,
    :status,
    :user_id,
    :tailor_id,
    :fabric_type,
    { order_items_attributes: OrderItem::ATTRIBUTES_WHITELIST,
      order_images_attributes: OrderImage::ATTRIBUTES_WHITELIST }
  ].freeze

  belongs_to :user
  belongs_to :proposal
  belongs_to :tailor, class_name: 'User'

  has_many :order_items
  has_many :order_images
  has_one :review

  validates :number, :year, :name, :fabric_type, presence: true

  accepts_nested_attributes_for :order_items, allow_destroy: true
  accepts_nested_attributes_for :order_images, allow_destroy: true

  enum status: STATUS
  enum fabric_type: FABRIC_TYPE

  def as_json
    super(
      {
        include: {
          order_images: { only: %i[id image]},
          review: { order_items: {} },
          user: { only: %i[first_name last_name email] },
          tailor: { only: %i[first_name last_name email] },
          order_items: {
            include: {
              skill: { only: %i[id name] },
              category: { only: %i[id name] },
              size_profile: {
                only: %i[id name gender],
                include: {
                  size_profile_fields: { include: {
                    standard_field: {}
                  } }
                }
              },
              order_item_size_profile: {
                include: {
                  order_item_size_profile_fields: { include: {
                    standard_field: {}
                  } }
                }
              }
            }
          }
        }
      }
    )
  end
end
