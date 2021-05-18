require 'will_paginate/array'

class Customers::ProposalBiddings::Searcher
  def self.call(current_user, opts)
    new(
      current_user,
      opts,
    ).call
  end

  def initialize(current_user, opts)
    @opts           = opts
    @current_user   = current_user
    @status         = opts[:status]
    @page           = opts[:page]
    @per_page       = opts[:per_page]
  end

  def call
    @biddings = ProposalBidding.by_proposal(current_user.proposal_ids).by_status(status)
    @biddings.paginate(per_page: per_page, page: page)
  end

  private

  attr_reader :current_user, :page, :per_page, :status

end
