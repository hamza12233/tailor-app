class OrderImage < ApplicationRecord
  mount_uploader :image, OrderImageUploader

  ATTRIBUTES_WHITELIST = [
    :id,
    :order_id,
    :image
  ].freeze
  belongs_to :order
end
