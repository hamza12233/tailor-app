class Api::V1::TailorSkillsController < ApplicationController
  before_action :find_tailor_skill, only: [:show, :destroy]

  def show
      render json: @tailor_skill,  status: :ok
  end

  def destroy
    if current_user.tailor_skills.exists?(@tailor_skill.id)
      @tailor_skill.destroy
      render json: { message: "Skill deleted successfully." }, status: :ok
    else
      render json: { errors: @tailor_skill.errors.full_messages }, status: 422
    end
  end


  private

  def find_tailor_skill
    @tailor_skill = TailorSkill.find(params[:id])
  end

end
