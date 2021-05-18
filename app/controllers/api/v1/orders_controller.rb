# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_user!
      before_action :find_order, only: %i[show]
      include Api::Pagination

      def index
        @order = current_user.orders
        @order = @order.paginate(per_page: per_page, page: page)
        render json: { order: @order.as_json, meta_attributes: meta_attributes(@order) }, status: 200
      end

      def show
        render json: { order: @order.as_json }, status: :ok
      end

      private

      def find_order
        @order = current_user.orders.find(params[:id])
      end
    end
  end
end
