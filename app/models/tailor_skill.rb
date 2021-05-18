class TailorSkill < ApplicationRecord

  ATTRIBUTES_WHITELIST = [
    :experience,
    :description,
    :user_id,
    :skill_id,
    :cost,
    :id
  ].freeze

  belongs_to :user
  belongs_to :skill
  validates :experience, :description, :cost, presence: true
  validates :skill_id, uniqueness: { scope: [:user_id]}, on: :create

  def skill_name
    skill&.name
  end

  def skill_category
    skill&.category
  end
end
