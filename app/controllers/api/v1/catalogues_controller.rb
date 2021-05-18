class Api::V1::CataloguesController < ApplicationController
  before_action :find_catalogue, only: %i[update show]

  def index
    @catalogues = Catalogue.all
    render json: { catalogues: @catalogues.as_json }, status: :ok
  end

  def create
    @catalogue = Catalogue.create(catalogue_params)
    render json: @catalogue.as_json, status: 201
  end

  def update
    if @catalogue.update(catalogue_params)
      render json: @catalogue.as_json, status: 201
    else
      render json: { errors: @catalogue.errors.full_messages }, status: 422
    end
  end

  def show
    render json: @catalogue.as_json, status: 201
  end

  private

  def find_catalogue
    @catalogue = Catalogue.find(params[:id])
  end

  def catalogue_params
    params.require(:catalogue).permit(*Catalogue::ATTRIBUTES_WHITELIST)
  end
end
