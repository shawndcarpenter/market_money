class Api::V0::NearestAtmsController < ApplicationController
  def index
    market = Market.find(params[:id])
    atms = AtmSearchFacade.new(market).atms
    render json: AtmSerializer.format_atms(atms)
  end
end