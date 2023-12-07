class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def create
    market = Market.find(params["market_vendor"][:market_id])
    vendor = Vendor.find(params["market_vendor"][:vendor_id])
    market_vendor = MarketVendor.new(market_id: market.id, vendor_id: vendor.id)
    if market_vendor.save
      success_response
    end
  end

  def destroy
    params_market_id = params["market_vendor"][:market_id]
    params_vendor_id = params["market_vendor"][:vendor_id]
    market_vendor = MarketVendor.where(market_id: params_market_id).where(vendor_id: params_vendor_id).first
    
    if market_vendor != nil
      render json: MarketVendor.delete(market_vendor.id), status: 204
    else
      no_market_vendor_response(params_market_id, params_vendor_id)
    end
  end

  private
  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end

  def invalid_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422))
    .serialize_json, status: :not_found
  end

  def no_market_vendor_response(market_id, vendor_id)
    render json:  {
      "errors": [{
      "detail": "No MarketVendor with market_id=#{market_id} AND vendor_id=#{vendor_id} exists"
      }]}, status: 404
  end

  def success_response
      render json:  {
        "message": "Successfully added vendor to market"
      }
  end
end