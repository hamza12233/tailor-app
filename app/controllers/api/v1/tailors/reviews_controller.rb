# frozen_string_literal: true

module Api
  module V1
    module Tailors
      class ReviewsController < ApplicationController
        include Api::Pagination

        def index
          @reviews = Review.for_tailor(params[:id]).paginate(per_page: per_page, page: page)
          render json: { review: @reviews.as_json, meta_attributes: meta_attributes(@reviews), success: true },
                 status: :ok
        end

        def update
          @comment = Review.find(params[:id])
          if @comment.update(tialor_comment_params)
            render json: { review: @comment.as_json, success: true }, status: :ok
          else
            render json: { review: @comment.errors.full_messages, success: false }, status: 422
          end
        end

        private

        def tialor_comment_params
          params.require(:review).permit(:comment)
        end
      end
    end
  end
end
