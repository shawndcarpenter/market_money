require 'rails_helper'

describe "Market Vendors" do
  it "sends a list of vendors for a particular market" do
    market = create(:market)
    id = market.id
    market.vendors = FactoryBot.create_list(:vendor, 5)

    get "/api/v0/markets/#{id}/vendors"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    vendors = JSON.parse(response.body, symbolize_names: true)

    expect(vendors[:data].count).to eq(5)

    vendors[:data].each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id].to_i).to be_a(Integer)

      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to be_a(String)
      expect(vendor[:type]).to eq("vendor")
     
      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to be_an(Hash)
     
      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a(String)
     
      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a(String)
     
      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a(String)
     
      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a(String)
     
      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
    end
  end

  describe "sad paths" do
    it "will gracefully handle if a market id doesn't exist" do
      get "/api/v0/markets/123123123123/vendors"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end

  describe "create market vendors" do
    it "can create a new relationship between a market and a vendor" do 
      market = create(:market)
      vendor = create(:vendor)

      expect(market.vendors).to_not include(vendor)
      market_vendor_params =  {
        market_id: market.id,
        vendor_id: vendor.id
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      expect(response).to be_successful
      
      data = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
  
      expect(data[:message]).to eq("Successfully added vendor to market")
      
    end
  end
end