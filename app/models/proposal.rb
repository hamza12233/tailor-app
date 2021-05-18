# frozen_string_literal: true

class Proposal < ApplicationRecord
  STATUS = {
    draft: 0,
    approved: 1,
    declined: 2
  }.freeze

  FABRIC_TYPE = {
    fabric: 0,
    inspiration: 1
  }.freeze

  ATTRIBUTES_WHITELIST = [
    :urgency_type,
    :comment,
    :status,
    :user_id,
    :name,
    :fabric_type,
    {
      proposal_items_attributes: ProposalItem::ATTRIBUTES_WHITELIST,
      proposal_images_attributes: ProposalImage::ATTRIBUTES_WHITELIST,
      proposal_biddings_attributes: ProposalBidding::ATTRIBUTES_WHITELIST
    }
  ].freeze

  has_many :proposal_items
  has_many :proposal_images
  has_many :inspiration_images
  has_many :proposal_biddings
  has_many :tailors, through: :proposal_biddings, foreign_key: 'user_id', class_name: 'User'
  has_one  :order

  belongs_to :user

  accepts_nested_attributes_for :proposal_items, allow_destroy: true
  accepts_nested_attributes_for :proposal_images, allow_destroy: true
  accepts_nested_attributes_for :proposal_biddings, allow_destroy: true

  validates :number, :year, :name, :fabric_type, presence: true

  scope :by_tailor, ->(tailor) { joins(:proposal_biddings).where(proposal_biddings: { user_id: tailor.id }) }
  scope :by_customer, ->(customer) { where(user: customer) }
  scope :by_current_year, -> { where(year: Time.zone.now.year) }
  scope :by_customer_and_status, ->(customer, status) { where(user: customer, status: status) }

  enum status: STATUS
  enum fabric_type: FABRIC_TYPE

  after_initialize do
    self.status ||= :draft if new_record?
  end

  def as_json
    super(
      {
        include: {
          proposal_items: {
            include: {
              size_profile: {},
              skill: { only: %i[id name] },
              category: { only: %i[id name] }
            }
          },
          proposal_biddings: {
            include: {
              tailor: { only: %i[first_name last_name email] }
            }
          },
          proposal_images: { only: %i[id image] },
          inspiration_images: { only: %i[id image description] },
          order: {
            include: {
              order_images: { only: %i[id image] },
              order_items: {}
            }
          }
        }
      }
    )
  end

  def send_bidding_email
    tailors.each do |tailor|
      ProposalMailer.send_bidding_email(tailor, user).deliver_now
    end
  end

  def skills
    skills = Skill.includes(:category).by_id(self.skill_ids)
    skills.map do |skill|
      {
        skill: skill,
        category: skill.category
      }
    end
  end
end
