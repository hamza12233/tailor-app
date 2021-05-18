# frozen_string_literal: true

class ProposalBidding < ApplicationRecord
  STATUS = {
    pending: 0,
    tailor_approved: 1,
    customer_approved: 2,
    tailor_declined: 3,
    customer_declined: 4,
    discard: 5
  }.freeze

  ATTRIBUTES_WHITELIST = %i[
    id
    status
    bidding_price
    due_date
    user_id
    proposal_id
    invite_only
  ].freeze

  TAILOR_APPROVED = 'tailor_approved'

  belongs_to :tailor, foreign_key: 'user_id', class_name: 'User'
  belongs_to :proposal

  enum status: STATUS

  scope :by_tailor, ->(tailor) { where(tailor: tailor) }
  scope :by_proposal, ->(proposal_ids) { where(proposal_id: proposal_ids) }
  scope :by_status, ->(status) { where(status: status) }

  after_initialize do
    self.status ||= :pending if new_record?
  end

  def as_json
    super(
      {
        include: {
          tailor: { only: %i[first_name last_name email] },
          proposal: {
            include: {
              proposal_images: { only: %i[image] },
              user: { only: %i[email first_name last_name] },
              proposal_items: {
                include: {
                  size_profile: {},
                  skill: { only: %i[id name] },
                  category: { only: %i[id name] }
                }
              }
            }
          }
        }
      }
    )
  end

  def notify_customer_bidding_approved
    BiddingMailer.notify_customer_bidding_approved(proposal).deliver_now
  end

  def notify_customer_bidding_rejected
    BiddingMailer.notify_customer_bidding_rejected(proposal).deliver_now
  end

  def notify_tailor_bidding_revoked(tailor)
    BiddingMailer.notify_tailor_bidding_revoked(tailor, proposal).deliver_now
  end

  def notify_tailor_bidding_rejected
    BiddingMailer.notify_tailor_bidding_rejected(tailor, proposal).deliver_now
  end

  def notify_tailor_bidding_approved
    BiddingMailer.notify_tailor_bidding_approved(tailor, proposal).deliver_now
  end
end
