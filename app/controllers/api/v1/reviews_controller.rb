# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :authenticate_user!
      before_action :find_review, only: [:update]

      def create
        @review = current_user.reviews.create(review_params)
        if @review.save
          render json: { review: @review.as_json, success: true }, status: :ok
        else
          render json: { review: @review.errors.full_messages, success: false }, status: 422
        end
      end

      def update
        if @review.update(review_params)
          render json: { review: @review.as_json, success: true }, status: :ok
        else
          render json: { review: @review.errors.full_messages, success: false }, status: 422
        end
      end

      private

      def review_params
        params.require(:review).permit(*Review::ATTRIBUTES_WHITELIST)
      end

      def find_review
        @review = Review.find(params[:id])
      end
    end
  end
end
