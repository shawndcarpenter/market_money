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
    vendor = Vendor.find(params[:id])
    invalid_params(vendor_params, vendor)
    render json: VendorSerializer.new(Vendor.update(params[:id], vendor_params))
  end

  def destroy 
    vendor = Vendor.find(params[:id])
    if vendor
      render json: Vendor.delete(params[:id]), status: 204
    end
  end

  private
  def invalid_params(vendor_params, vendor)
    list_of_invalid_params = []
    vendor_params.each do |key, value|
      if value == ""
        list_of_invalid_params << key
      end
    end
    set_to_nil(list_of_invalid_params, vendor)
  end

  def set_to_nil(list_of_invalid_params, vendor)
    list_of_invalid_params.each do |param|
      if param == "contact_name"
        vendor.update!(contact_name: nil)
      elsif param == "name"
        vendor.update!(name: nil)
      elsif param == "contact_phone"
        vendor.update!(contact_phone: nil)
      elsif param == "description"
        vendor.update!(description: nil)
      elsif param == "credit_accepted"
        vendor.update!(credit_accepted: nil)
      end
    end
  end

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