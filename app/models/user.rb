# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models # added this line to extend devise model
  include PgSearch

  ROLES = {
    super_admin: 0,
    admin: 1,
    tailor: 2,
    customer: 3,
    staff: 4
  }.freeze

  GENDER_TYPES = {
    male: 0,
    female: 1
  }.freeze

  ATTRIBUTES_WHITELIST = [
    :id,
    :email,
    :password,
    :new_password,
    :password_confirmation,
    :role,
    :first_name,
    :last_name,
    :cnic,
    :dob,
    :phone_number,
    :whatsapp_number,
    :about_me,
    :gender,
    :profile_photo,
    :cover_photo,
    :street,
    :city,
    :zip,
    :state,
    :country,
    { category_ids: [],
      skill_ids: [],
      portfolios_attributes: Portfolio::ATTRIBUTES_WHITELIST,
      tailor_skills_attributes: TailorSkill::ATTRIBUTES_WHITELIST,
      reviews_attributes: Review::ATTRIBUTES_WHITELIST }
  ].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  before_validation :downcase_email
  validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :city, allow_blank: true, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: 'only allows letters' }
  validates :whatsapp_number, :phone_number, length: { is: 11, message: 'must contains 11 digits' },
                                             allow_blank: true, format: { with: /\A[0-9]*\z/ }
  validates :cnic, length: { is: 13, message: 'must contains 13 digits' }, allow_blank: true,
                   format: { with: /\A[0-9]*\z/ }
  validates :zip, length: { is: 5, message: 'must contains 5 digits' }, allow_blank: true,
                  format: { with: /\A[0-9]*\z/ }

  before_validation :name_senitize

  has_many :portfolios
  has_many :tailor_skills
  has_many :skills, through: :tailor_skills
  has_many :categories, through: :skills
  has_many :reviews
  has_many :proposals
  has_many :orders
  has_many :order_items
  has_many :proposal_biddings, through: :proposals
  has_many :favorite_tailors, class_name: 'FavoriteTailor', foreign_key: 'user_id'
  has_many :profile_sizings
  has_many :order_sizings
  has_many :size_profiles
  has_many :order_item_size_profiles
  has_many :tailor_orders, class_name: 'Order', foreign_key: 'tailor_id'
  has_many :tailor_reviews, class_name: 'Review', foreign_key: 'tailor_id'

  accepts_nested_attributes_for :portfolios, allow_destroy: true
  accepts_nested_attributes_for :tailor_skills, allow_destroy: true
  accepts_nested_attributes_for :reviews, allow_destroy: true

  scope :search_by_category, ->(category_id) { joins(:categories).where(categories: { id: category_id }) }
  scope :search_by_skills, ->(skill_id) { joins(:skills).where(skills: { id: skill_id }) }
  scope :sort_by_experience_and_skill, ->(col, dir) { joins(:tailor_skills).order("tailor_skills.#{col} #{dir}") }
  scope :by_ids, ->(ids) { where(id: ids) }

  enum role: ROLES
  enum gender: GENDER_TYPES

  mount_uploader :profile_photo, ProfilePhotoUploader
  mount_uploader :cover_photo, CoverPhotoUploader

  pg_search_scope :search_by_keyword,
                  against: [:first_name, :last_name, :phone_number, :email],
                  using:   {
                    tsearch: {
                      prefix:   true,
                      any_word: true
                    }
                  }

  def as_json(options = {})
    if options[:info_only] == true
      super(only: %i[first_name last_name city experience country gender about_me state])
    else
      super(
        {
          methods: %i[average_categories_cost experience average_rating],
          include: {
            portfolios: { only: %i[id title description category_id],
                          include: { portfolio_images: { only: %i[id image] } } },
            tailor_skills: { only: %i[id experience description skill_id cost],
                             methods: %i[skill_name skill_category] },
            tailor_reviews: {
              include: {
                user: { only: %i[first_name last_name email] }
              }
            }
          }
        }
      )
    end
  end

  def average_categories_cost
    return nil if customer?

    tailor_skills.joins(:skill).group(:category_id).average(:cost).transform_values { |v| v.round(2).abs }
  end

  def experience
    return nil if customer?

    tailor_skills.sum(:experience)
  end

  def average_rating
    return nil if customer?

    self.tailor_reviews.average(:rating)
  end

  def favorite_tailor?(tailor)
    favorite_tailors.pluck(:tailor_id).include?(tailor.id)
  end

  private

  def downcase_email
    return if email.blank?

    self.email = email.strip.downcase
    self.uid = email
  end

  def name_senitize
    self.first_name = first_name.to_s.strip
    self.last_name = last_name.to_s.strip
    self.city = city.to_s.strip
  end
end
