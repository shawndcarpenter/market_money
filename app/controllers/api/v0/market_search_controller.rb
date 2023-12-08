class Api::V0::MarketSearchController < ApplicationController
  def index
    if params[:state].present? && params[:city].present? && params[:name].present?
      searched_markets = Market.search_by_city_and_state_and_name(params[:city], params[:state], params[:name])
      render json: MarketSerializer.new(searched_markets)
    elsif params[:state].present? && params[:city].present?
      searched_markets = Market.search_by_city_and_state(params[:city], params[:state])
      render json: MarketSerializer.new(searched_markets)
    elsif params[:state].present? && params[:name].present?
      searched_markets = Market.search_by_state_and_name(params[:state], params[:name])
      render json: MarketSerializer.new(searched_markets)
    elsif params[:state].present?
      searched_markets = Market.search_by_state(params[:state])
      render json: MarketSerializer.new(searched_markets)
    elsif params[:name].present? && !params[:city].present?
      searched_markets = Market.search_by_name(params[:name])
      render json: MarketSerializer.new(searched_markets)
    else
      render json: {
        "errors": [
            {
                "detail": "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."
            }
        ]
      }, status: 422
    end
  end
end