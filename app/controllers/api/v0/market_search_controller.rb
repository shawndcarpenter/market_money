class Api::V0::MarketSearchController < ApplicationController
  def index
    raise InvalidSearch unless is_valid?(params)
    find_matching_market(params)
  end

  private
  def is_valid?(params)
    (params[:state].present? && params[:city].present? && params[:name].present?) ||
    (params[:state].present? && params[:city].present?) ||
    (params[:state].present? && params[:name].present?) ||
    (params[:state].present?) ||
    (params[:name].present? && !params[:city].present?)
  end

  def find_matching_market(params)
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
    end
  end
end