require 'rails_helper'

describe "Nearest ATMs" do
  it "finds the nearest ATMs to a market" do
    market_params = ({
              name: "Nob Hill Growers' Market",
              street: "Lead & Morningside SE",
              city: "Albuquerque",
              county: "Bernalillo",
              state: "New Mexico",
              zip: "null",
              lat: "35.077529",
              lon: "-106.600449"
          })
    headers = {"CONTENT_TYPE" => "application/json"}

    market = Market.create!(market_params)
    get "/api/v0/markets/#{market.id}/nearest_atms", headers: headers
    
    # binding.pry
    expect(response).to be_successful
    # expect(response.status).to eq(200)

    atms = JSON.parse(response.body, symbolize_names: true)[:data]

    atms.each do |atm|
      expect(atm).to have_key(:id)
      expect(atm).to have_key(:type)
      expect(atm[:type]).to eq("atm")

      expect(atm).to have_key(:attributes)
      expect(atm[:attributes]).to be_an(Hash)

      expect(atm[:attributes]).to have_key(:name)
      expect(atm[:attributes][:name]).to eq("ATM")

      expect(atm[:attributes]).to have_key(:address)
      expect(atm[:attributes][:address]).to be_a(String)

      expect(atm[:attributes]).to have_key(:lat)
      expect(atm[:attributes][:lat]).to be_a(Float)

      expect(atm[:attributes]).to have_key(:lon)
      expect(atm[:attributes][:lon]).to be_a(Float)

      expect(atm[:attributes]).to have_key(:distance)
      expect(atm[:attributes][:distance]).to be_a(Float)
    end
  end
end