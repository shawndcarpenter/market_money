class Api::V0::MarketSearchController < ApplicationController
  def index
    # binding.pry
    if params[:state].present?
      searched_markets = Market.search_by_state(params[:state])
    elsif params[:state].present? && params[:city].present?
      searched_markets = Market.search_by_city_and_state(params[:city], params[:state])
    elsif params[:state].present? && params[:city].present? && params[:name].present?
      searched_markets = Market.search_by_city_and_state_and_name(params[:city], params[:state], params[:name])
    elsif params[:state].present? && params[:name].present?
      searched_markets = Market.search_by_state_and_name(params[:state], params[:name])
    elsif params[:name].present?
      searched_markets = Market.search_by_name(params[:name])
    end

    render json: MarketSerializer.new(searched_markets)
  end
end