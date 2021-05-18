module Api
  module Pagination
    extend ActiveSupport::Concern

    DEFAULT_PER_PAGE = 30
    PAGE_NUMBER      = 1

    def meta_attributes(collection, extra_meta = {})
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.previous_page,
        total_pages: collection.total_pages,
        total_count: collection.total_entries
      }.merge(extra_meta)
    end

    def per_page
      @per_page = params.fetch(:per_page, DEFAULT_PER_PAGE).to_i
      return 30 if @per_page.zero?

      @per_page
    end

    def page
      @page = params.fetch(:page, PAGE_NUMBER).to_i
      return 1 if @page.zero?

      @page
    end
  end
end
