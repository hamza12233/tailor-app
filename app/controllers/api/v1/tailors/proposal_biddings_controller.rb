# frozen_string_literal: true

module Api
  module V1
    module Tailors
      class ProposalBiddingsController < ApplicationController
        before_action :authenticate_user!
        before_action :find_proposal, only: [:show]
        before_action :find_bidding, only: %i[accept reject]
        before_action :validate, only: %i[accept reject]
        include Api::Pagination

        def index
          @biddings = ::Tailors::ProposalBiddings::Searcher.call(current_user, params)
          render json: { biddings: @biddings.as_json, meta_attributes: meta_attributes(@biddings) }, status: :ok
        end

        def show
          @bidding = @proposal.proposal_biddings.find_by(user_id: current_user.id)
          if @bidding.present? && !@bidding.discard?
            render json: @bidding.as_json, status: 201
          else
            render json: { message: 'No bidding found for the provided proposal id' }, status: 422
          end
        end

        def accept
          if @bidding.update(bidding_params)
            @bidding.tailor_approved!
            @bidding.notify_customer_bidding_approved
            render json: { message: 'Bidding has been accepted successfully', bidding: @bidding.as_json }, status: 201
          else
            render json: { message: @bidding.errors }, status: 422
          end
        end

        def reject
          if @bidding.tailor_declined!
            @bidding.notify_customer_bidding_rejected
            render json: { message: 'Bidding has been rejected', bidding: @bidding.as_json }, status: 201
          else
            render json: { message: @bidding.errors }, status: 422
          end
        end

        private

        def find_proposal
          @proposal = Proposal.by_tailor(current_user).find(params[:proposal_id])
        end

        def find_bidding
          @bidding = ProposalBidding.by_tailor(current_user).find(params[:id])
        end

        def bidding_params
          params.require(:proposal_bidding).permit(*ProposalBidding::ATTRIBUTES_WHITELIST)
        end

        def validate
          if @bidding.discard?
            render json: { message: 'you are no longer able to bid for this order' }, status: 422
          elsif @bidding.tailor_approved? || @bidding.tailor_declined?
            render json: { message: 'you have already submitted response against this bidding.' }, status: 422
          end
        end
      end
    end
  end
end
