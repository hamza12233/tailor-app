require 'will_paginate/array'

class Tailors::ProposalBiddings::Searcher
  def self.call(current_user, opts)
    new(
      current_user,
      opts,
    ).call
  end

  def initialize(current_user, opts)
    @opts                 = opts
    @current_user         = current_user
    @status               = opts[:status]
    @per_page             = opts[:per_page]
    @page                 = opts[:page]
  end

  def call
    @biddings = ProposalBidding.by_tailor(current_user).by_status(status)
    @biddings.paginate(per_page: per_page, page: page)
  end

  private

  attr_reader :current_user, :page, :per_page, :status

end
