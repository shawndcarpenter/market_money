require 'rails_helper'

RSpec.describe MarketSerializer, type: :request do
  describe "serializing" do
    it "can work" do
      create(:market)
      headers = {"CONTENT_TYPE" => "application/json"}

      get "/api/v0/markets", headers: headers

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)
      market = data[:data][0]
      expect(market).to be_a Hash

      expect(market).to have_key(:id)

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)

      expect(market).to have_key(:type)
      expect(market[:type]).to be_a(String)
      expect(market[:type]).to eq("market")
     
      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_an(Hash)
     
      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)

      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a(String)

      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)
       
      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_a(Integer)
    end
  end
end