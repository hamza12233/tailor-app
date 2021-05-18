# frozen_string_literal: true
module Api::V1
  class SizeProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_size_profile, only: %i[update show destroy]
  include Api::Pagination

  def index
    @size_profiles = current_user.size_profiles
    @size_profiles = @size_profiles.paginate(per_page: per_page, page: page)
    render json: { success: true, size_profiles: @size_profiles.as_json, meta_attributes: meta_attributes(@size_profiles) }, status: 200
  end

  def show
    render json: { success: true, size_profile: @size_profile.as_json }, status: 200
  end

  def create
    @size_profile = current_user.size_profiles.new(size_profile_params)
    if @size_profile.save
      render json: { success: true, size_profile: @size_profile.as_json }, status: 201
    else
      render json: { errors: @size_profile.errors.full_messages }, status: 422
    end
  end

  def update
    if @size_profile.update(size_profile_params)
      render json: { success: true, size_profile: @size_profile.as_json }, status: 200
    else
      render json: { success: false, errors: @size_profile.errors.full_messages }, status: 422
    end
  end

  def destroy
    @size_profile.destroy
    render json: { success: true, messages: 'Profile sizing destroyed successfully' }, status: 200
    rescue ActiveRecord::InvalidForeignKey
      render json: { success: false, errors: ['This size guide is attached with an order.'] },
                     status: :unprocessable_entity
  end

  private

  def size_profile_params
    params.require(:size_profile).permit(*SizeProfile::ATTRIBUTES_WHITELIST)
  end

  def find_size_profile
    @size_profile = current_user.size_profiles.find(params[:id])
  end
  end
end
