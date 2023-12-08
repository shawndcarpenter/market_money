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
    searched_markets = []
    params.each do |key, value|
      if key == "state" && searched_markets == []
        searched_markets = Market.where("lower(state) ilike ?", "%#{value.downcase}%")
      elsif key == "state"
        searched_markets = searched_markets.where("lower(state) ilike ?", "%#{value.downcase}%")
      elsif key == "city" && searched_markets == []
        searched_markets = Market.where("lower(city) ilike ?", "%#{value.downcase}%")
      elsif key == "city"
        searched_markets = searched_markets.where("lower(city) ilike ?", "%#{value.downcase}%")
      elsif key == "name" && searched_markets == []
        searched_markets = Market.where("lower(name) ilike ?", "%#{value.downcase}%")
      elsif key == "name"
        searched_markets = searched_markets.where("lower(name) ilike ?", "%#{value.downcase}%")
      end
    end
    render json: MarketSerializer.new(searched_markets), status: 200
  end
end