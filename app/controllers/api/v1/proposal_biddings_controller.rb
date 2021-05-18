class Api::V1::ProposalBiddingsController < ApplicationController
  include Api::Pagination
  
  def index
    @biddings = ::Customers::ProposalBiddings::Searcher.call(current_user, params)
    render json: { biddings: @biddings.as_json, meta_attributes: meta_attributes(@biddings) }, status: :ok
  end

end
