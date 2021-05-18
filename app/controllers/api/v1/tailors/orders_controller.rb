class Api::V1::Tailors::OrdersController < ApplicationController
  include Api::Pagination

  def index
    @orders = current_user.tailor_orders.paginate(per_page: per_page, page: page)
    render json: { orders: @orders.as_json, meta_attributes: meta_attributes(@orders) }, status: 200
  end

end
