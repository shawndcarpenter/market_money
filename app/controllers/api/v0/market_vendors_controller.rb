class Api::V0::MarketVendorsController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def create
    market = Market.find(params["market_vendor"][:market_id])
    vendor = Vendor.find(params["market_vendor"][:vendor_id])
    market_vendor = MarketVendor.new(market_id: market.id, vendor_id: vendor.id)
    if market_vendor.save
      render json:    {
        "message": "Successfully added vendor to market"
      }
    end
  end

  def destroy
    # market = Market.find(params["market_vendor"][:market_id])
    # binding.pry
    @params_market_id = params["market_vendor"][:market_id]
    @params_vendor_id = params["market_vendor"][:vendor_id]
    # vendor = Vendor.find(params["market_vendor"][:vendor_id])
    market_vendor = MarketVendor.where(market_id: @params_market_id).where(vendor_id: @params_vendor_id).first
    # binding.pry
    if market_vendor != nil
      render json: MarketVendor.delete(market_vendor.id), status: 204
    else
      render json:  {
                "errors": [{
                "detail": "No MarketVendor with market_id=#{@params_market_id} AND vendor_id=#{@params_vendor_id} exists"
                }]}, status: 404
    end
  end

  private
  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
    .serialize_json, status: :not_found
  end

  def invalid_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422))
    .serialize_json, status: :not_found
  end
end