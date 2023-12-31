class Api::V0::MarketsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    markets = Market.all
    render json: MarketSerializer.new(markets)
  end
  
  def show
    render json: 
    MarketSerializer.new(Market.find(params[:id]))
  end

  private
  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
    .serialize_json, status: :not_found
  end
end