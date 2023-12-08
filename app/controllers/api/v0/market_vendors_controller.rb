class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def create
    params_market_id = params["market_vendor"][:market_id]
    params_vendor_id = params["market_vendor"][:vendor_id]

    if MarketVendor.where("market_id = #{params_market_id} and vendor_id = #{params_vendor_id}") != []
      market_vendor_exists(params_market_id, params_vendor_id)
    elsif Market.where("id = #{params_market_id}") == []
      no_market_response
    else
      market_vendor = MarketVendor.new(market_id: params_market_id, vendor_id: params_vendor_id)
      if market_vendor.save
        success_response
      else
        no_market_vendor_response(params_market_id, params_vendor_id)
      end
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
  def invalid_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422))
    .serialize_json, status: :not_found
  end

  def no_market_response
    render json: ErrorSerializer.new(
      ErrorMessage.new(
        "Validation failed: Market must exist", 404
      )).serialize_json, status: 404
  end

  def market_vendor_exists(market_id, vendor_id)
    render json: ErrorSerializer.new(
      ErrorMessage.new(
        "Validation failed: Market vendor asociation between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists", 422
      )).serialize_json, status: 422
  end

  def no_market_vendor_response(market_id, vendor_id)
    render json: ErrorSerializer.new(
      ErrorMessage.new(
        "No MarketVendor with market_id=#{market_id} AND vendor_id=#{vendor_id} exists", 404
      )).serialize_json, status: 404
  end

  def success_response
      render json:  {
        "message": "Successfully added vendor to market"
      }, status: 201
  end
end