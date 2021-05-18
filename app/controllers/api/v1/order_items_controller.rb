# frozen_string_literal: true

module Api
  module V1
    class OrderItemsController < ApplicationController
      before_action :authenticate_user!
      before_action :find_order_item, only: %i[toggle_size_profile]

      def toggle_size_profile
        if @order_item.toggle_size_profile(order_item_profile['size_profile_id'])
          render json: { success: true, message: 'Order item size profile updated successfully' }
        else
          render json: { success: false, errors: @order_item.errors.full_messages  }
        end
      end

      private

      def find_order_item
        @order = current_user.orders.find_by(id: params[:id])

        @order_item = @order.order_items.find_by(id: params[:order_item_id])
      end

      def order_item_profile
        params.require(:order_item).permit(:size_profile_id)
      end
    end
  end
end
