class Api::V0::NearestAtmsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    market = Market.find(params[:id])
    atms = AtmSearchFacade.new(market).atms
    render json: AtmSerializer.format_atms(atms)
  end

  private
  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
    .serialize_json, status: 404
  end
end