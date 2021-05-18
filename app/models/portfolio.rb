class Portfolio < ApplicationRecord
  ATTRIBUTES_WHITELIST = [
    :title,
    :description,
    :user_id,
    :category_id,
    :id,
    portfolio_images_attributes: PortfolioImage::ATTRIBUTES_WHITELIST,
  ].freeze

  validates :title, :description, presence: true

  has_many :portfolio_images, dependent: :destroy
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :portfolio_images, allow_destroy: true

end
