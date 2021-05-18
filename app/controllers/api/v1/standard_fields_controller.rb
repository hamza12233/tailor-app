# frozen_string_literal: true

module Api
  module V1
    class StandardFieldsController < ApplicationController
      before_action :authenticate_user!

      def index
        @standard_fields = StandardField.both
        @standard_fields |= StandardField.women if for_women
        @standard_fields |= StandardField.men if for_men

        render json: { standard_fields: @standard_fields.as_json }, status: :ok
      end

      private

      def for_women
        params[:for_gender] == StandardField::WOMEN
      end

      def for_men
        params[:for_gender] == StandardField::MEN
      end
    end
  end
end
