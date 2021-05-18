# frozen_string_literal: true

module Api
  module V1
    class PortfoliosController < ApplicationController
      before_action :find_portfolio, only: %i[show destroy]

      def show
        render json: @portfolio, status: :ok
      end

      def destroy
        if current_user.portfolios.exists?(@portfolio.id)
          @portfolio.destroy
          render json: { message: 'Portfolio deleted successfully.' }, status: :ok
        else
          render json: { errors: @portfolio.errors.full_messages }, status: 422
        end
      end

      private

      def find_portfolio
        @portfolio = Portfolio.find(params[:id])
      end
    end
  end
end
