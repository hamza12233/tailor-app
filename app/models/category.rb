class Category < ApplicationRecord
  Category_Types = {
    men: 0,
    women: 1,
    kids: 2
  }

  ATTRIBUTES_WHITELIST = [
    :name
  ].freeze

  has_many :skills
  has_many :tailor_skills, through: :skills

  validates :name, presence: true

  enum name: Category_Types

  def self.men_category
    men.first
  end
  def self.women_category
    women.first
  end
  def self.kids_category
    kids.first
  end

end
