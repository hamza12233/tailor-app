require 'will_paginate/array'
module Tailors
  class Searcher
    def self.call(current_user, opts = {})
      new(
        current_user,
        opts,
      ).call
    end

    def initialize(current_user, opts = {})
      @category_ids  =  opts[:category_ids].to_s.split(',').map(&:to_i)
      @skill_ids     =  opts[:skill_ids].to_s.split(',').map(&:to_i)
      @col           =  opts[:col]
      @dir           =  opts[:dir]
      @page          =  opts[:page]
      @per_page      =  opts[:per_page]
      @only_favorite =  opts[:only_favorite]
      @current_user  =  current_user
      @keyword       =  opts[:keyword]
    end

    def call
      users = User.tailor.joins(:tailor_skills)
      users = users.by_ids(current_user.favorite_tailors.pluck(:tailor_id)) if only_favorite.present? && current_user.present?
      users = users.search_by_category(category_ids) if category_ids.present?
      users = users.search_by_keyword(keyword) if keyword.present?
      users = users.search_by_skills(skill_ids) if skill_ids.present?
      users = users.sort_by_experience_and_skill(col, dir) if col.present? && dir.present?
      users.uniq.paginate(per_page: per_page, page: page)
    end

    private

    attr_reader :category_ids, :skill_ids, :page, :per_page, :col, :dir, :current_user, :only_favorite, :keyword
  end
end

