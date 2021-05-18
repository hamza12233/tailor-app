class Api::V1::SkillsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :find_skill, only: %i[show]

  include Api::Pagination

  def index
    @skills  = Skills::Searcher.call(secure_index_params)
    render json: { skills: @skills.as_json, meta_attributes: meta_attributes(@skills) }, status: :ok
  end

  def popular_skills
    result = OrderItem.joins(:skill).select("skills.name as skill_name, COUNT(order_items.id) as order_items_count").group("skills.name").order(order_items_count: :desc).first(10)
    @skills = result.to_a.map{|skill| {skill_name: skill.skill_name, orders_count: skill.order_items_count} }
    render json: { skills: @skills }, status: :ok
  end

  def show
    render json: { skill: @skill }, status: :ok
  end

  def secure_index_params
    params.permit(:category_id, :page, :per_page)
  end

  private

  def find_skill
    @skill = Skill.find_by(id: params[:id])
    render json: { success: false, message: 'Skill not present' } if @skill.blank?
  end
end
