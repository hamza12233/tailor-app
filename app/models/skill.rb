class Skill < ApplicationRecord
  ATTRIBUTES_WHITELIST = [
    :name,
    ].freeze

  belongs_to :category
  has_many :tailor_skills
  has_many :tailors, through: :tailor_skills, class_name: 'User', source: :user, foreign_key: :user_id
  has_many :order_items
  has_many :inspiration_images

  accepts_nested_attributes_for :inspiration_images, allow_destroy: true

  validates :name, presence: true

  scope :by_id, ->(ids) {where(id: ids)}

  def as_json(options = {})
    super(
      {
        include: {
          inspiration_images: { only: %i[id image description] }
        }
      }
    )
  end
end
