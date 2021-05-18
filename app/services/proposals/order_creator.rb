# frozen_string_literal: true

module Proposals
  class OrderCreator
    def self.call(proposal, tailor, accepted_bidding)
      new(proposal, tailor, accepted_bidding).call
    end

    def initialize(proposal, tailor, accepted_bidding)
      @proposal          =  proposal
      @tailor            = tailor
      @accepted_bidding  = accepted_bidding
    end

    def call
      order = Order.new(
        name: proposal.name,
        fabric_type: proposal.fabric_type,
        urgency_type: proposal.urgency_type,
        comment: proposal.comment,
        status: :in_progress,
        user_id: proposal.user_id,
        proposal_id: proposal.id,
        number: proposal.number,
        year: proposal.year,
        tailor_id: tailor.id,
        due_date: accepted_bidding.due_date,
        bidding_price: accepted_bidding.bidding_price
      )
      order.save!
      proposal.proposal_images.each do |img|
        OrderImage.create(order_id: order.id, image: img.image)
      end
      proposal.proposal_items.each do |proposal_item|
        order.order_items.create!({ user_id: proposal.user_id, category_id: proposal_item.category_id, tailor_id: tailor.id,
                                    skill_id: proposal_item.skill_id, size_profile_id: proposal_item.size_profile_id })
      end
    end

    private

    attr_accessor :proposal, :tailor, :accepted_bidding
  end
end
