class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response
  

  def index
    market = Market.find(params[:market_id])
    vendors = market.vendors.uniq
    render json: VendorSerializer.new(vendors)
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: 201
    else
      render json: VendorSerializer.new(Vendor.create!(vendor_params))
    end
  end

  def update
    if vendor_params[:contact_name] == ""
      vendor = Vendor.find(params[:id])
      vendor.update!(contact_name: nil)
      render json: VendorSerializer.new(Vendor.update(params[:id], vendor_params))
    else
      render json: VendorSerializer.new(Vendor.update(params[:id], vendor_params))
    end
  end

  def destroy 
    vendor = Vendor.find(params[:id])
    if vendor
      render json: Vendor.delete(params[:id]), status: 204
    end
  end

  private
  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
    .serialize_json, status: :not_found
  end

  def invalid_response(exception)
    if exception.message.include?("Validation failed")
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .serialize_json, status: 400
    else
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422))
      .serialize_json, status: :not_found
    end
  end

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end