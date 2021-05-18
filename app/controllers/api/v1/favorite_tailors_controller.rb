class Api::V1::FavoriteTailorsController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite_tailor = current_user.favorite_tailors.new(tailor_id: params[:id])
    if @favorite_tailor.save
      render json: {success: true, message: "Favorite tailor added"} , status: 200
    else
      render json: {success: false, errors: @favorite_tailor.errors.full_messages } , status: 422
    end
  end

  def destroy
    @favorite_tailor = current_user.favorite_tailors.find_by!(tailor_id: params[:id])
    @favorite_tailor.destroy
    render json: { success: true, message: "Favorite tailor removed" } , status: 200
  end

end
