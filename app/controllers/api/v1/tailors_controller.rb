class Api::V1::TailorsController < ApplicationController
  include Api::Pagination
  before_action :find_tailor, only: %i[show favorite_tailor]
  skip_before_action :authenticate_user!

  def index
    @tailors = Tailors::Searcher.call(current_user,secure_params.to_h.symbolize_keys)
    @meta    =  meta_attributes(@tailors)
  end

  def show
    render json: { tailor: @tailor.as_json.merge(favorite: favorite_tailor) }, status: :ok
  end

  def top_rated_tailors
    @tailors = User.tailor.joins(:tailor_reviews, :tailor_orders).where(orders: {status: :completed}).select(" users.first_name, users.last_name, users.email, users.about_me, users.profile_photo, users.state, users.country ,users.street, users.city, users.id, users.role, SUM(reviews.rating) , COUNT(orders)").group("users.id, reviews.id")
    @tailors = @tailors.uniq.paginate(per_page: per_page, page: page)
    render json: { tailors: @tailors.as_json, meta_attributes: meta_attributes(@tailors) }, status: :ok
  end


  private

  def secure_params
    params.permit(:page, :per_page, :category_ids, :skill_ids, :col, :dir, :only_favorite, :keyword)
  end

  def find_tailor
    @tailor = User.tailor.find(params[:id])
  end

  def favorite_tailor
    current_user.favorite_tailor?(@tailor) if current_user.present?
  end

end
