# frozen_string_literal: true
module Api::V1
  class OrderItemSizeProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_order_item_size_profile, only: %i[update show destroy]
    before_action :find_order_item, only: %i[update show destroy create]

    def show
      render json: { success: true, order_item_size_profile: @order_item_size_profile.as_json }, status: 200
    end

    def create
      @order_item_size_profile = @order_item.build_order_item_size_profile(order_item_size_profile_params)
      @order_item_size_profile.user_id = current_user.id
      if @order_item_size_profile.save
        render json: { success: true, order_item_size_profile: @order_item_size_profile.as_json }, status: 201
      else
        render json: { errors: @order_item_size_profile.errors.full_messages }, status: 422
      end
    end

    def update
      if @order_item_size_profile.update(order_item_size_profile_params)
        render json: { success: true, size_profile: @order_item_size_profile.as_json }, status: 200
      else
        render json: { success: false, errors: @order_item_size_profile.errors.full_messages }, status: 422
      end
    end

    def destroy
      @order_item_size_profile.destroy
      render json: { success: true, messages: 'Profile sizing destroyed successfully' }, status: 200
    end

    private

    def order_item_size_profile_params
      params.require(:order_item_size_profile).permit(*OrderItemSizeProfile::ATTRIBUTES_WHITELIST)
    end

    def find_order_item_size_profile
      @order_item_size_profile = current_user.order_item_size_profiles.find(params[:id])
    end

    def find_order_item
      @order_item = current_user.order_items.find(params[:order_item_id])
    end
  end
end
