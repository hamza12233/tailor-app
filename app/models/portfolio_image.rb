class PortfolioImage < ApplicationRecord
  mount_uploader :image, ImageUploader

  ATTRIBUTES_WHITELIST = [
    :id,
    :portfolio_id,
    :image,
    :_destroy
  ].freeze

  belongs_to :portfolio

end
