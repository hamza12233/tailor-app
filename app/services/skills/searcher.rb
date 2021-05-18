require 'will_paginate/array'
class Skills::Searcher

  def self.call(opts)
    new(opts).call
  end

  def initialize(opts)
    @category_id       =   opts[:category_id]
    @page              =   opts[:page]
    @per_page          =   opts[:per_page]
    @popular_skills    =   opts[:popular_skills]
  end

  def call
    @skills = Skill.all
    @skills = @skills.where(category_id: category_id) if category_id.present?
    @skills = @skills.paginate(per_page: per_page, page: page)
  end

  private

  attr_reader :category_id, :page, :per_page, :popular_skills
end
