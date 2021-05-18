# frozen_string_literal: true

module Api
  module V1
    class ProposalsController < ApplicationController
      before_action :authenticate_user!
      before_action :find_proposal, only: %i[show convert_to_order update customer_declined_bidding add_inspiration_images]
      before_action :get_all_proposals_by_customer, only: [:index]
      include Api::Pagination

      def index
        @proposals = @proposals.paginate(per_page: per_page, page: page)
        render json: { proposals: @proposals.as_json, meta_attributes: meta_attributes(@proposals) }, status: :ok
      end

      def show
        render json: { proposals: @proposal.as_json }, status: :ok
      end

      def create
        @proposal = Proposal.new(proposal_params)
        @proposal.user = current_user
        @proposal.year = Time.now.year
        @proposal.number = max_number + 1
        if @proposal.save
          render json: @proposal.as_json, status: 201
        else
          render json: { errors: @proposal.errors.full_messages }, status: 422
        end
      end

      def update
        if @proposal.update(proposal_params)
          @proposal.send_bidding_email
          render json: @proposal.as_json, status: 201
        else
          render json: { errors: @proposal.errors.full_messages }, status: 422
        end
      end

      def convert_to_order
        @accepted_bidding = @proposal.proposal_biddings.find(params[:proposal_bidding_id])
        @accepted_bidding.customer_approved!
        @accepted_bidding.notify_tailor_bidding_approved
        if @proposal.approved!
          @biddings = @proposal.proposal_biddings.tailor_approved
          if @biddings.present?
            @biddings.each do |bidding|
              bidding.discard!
              bidding.notify_tailor_bidding_revoked(bidding.tailor)
            end
          end
          @users = Proposals::OrderCreator.call(@proposal, @accepted_bidding.tailor, @accepted_bidding)
          render json: @proposal.as_json, status: 201
        else
          render json: { errors: @proposal.errors.full_messages }, status: 422
        end
      end

      def customer_declined_bidding
        @bidding = @proposal.proposal_biddings.find(params[:proposal_bidding_id])
        if @bidding.customer_declined!
          @bidding.notify_tailor_bidding_rejected
          render json: @proposal.as_json, status: 201
        else
          render json: { errors: @bidding.errors.full_messages }, status: 422
        end
      end

      def add_inspiration_images
        @inspiration_images = InspirationImage.where(id: params[:inspiration_ids])
        @inspiration_images.update_all(proposal_id: @proposal.id)
        render json: { messages: "Inspiration Images added successfully" }, status: 200
      end

      private

      def proposal_params
        params.require(:proposal).permit(*Proposal::ATTRIBUTES_WHITELIST)
      end

      def max_number
        current_user.proposals.by_current_year&.maximum(:number).to_i
      end

      def find_proposal
        @proposal = Proposal.by_customer(current_user).find(params[:id])
      end

      def get_all_proposals_by_customer
        @proposals = Proposal.by_customer_and_status(current_user, :draft)
      end
    end
  end
end
