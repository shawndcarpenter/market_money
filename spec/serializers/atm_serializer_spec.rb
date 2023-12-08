require 'rails_helper'

RSpec.describe AtmSerializer, type: :request do
  describe "serializing" do
    it "can work" do
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
      atms_near_nob_hill_fixture = File.read("spec/fixtures/atms_near_nob_hill.json")
      stub_request(:get, "https://api.tomtom.com/search/2/categorySearch/automatic_teller_machine.json?key=#{ENV["API_KEY"]}&lat=35.077529&lon=-106.600449&municipality=Albuquerque&streetName=Lead%20%26%20Morningside%20SE").
      with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.7.12'
      }).
      to_return(status: 200, body: atms_near_nob_hill_fixture, headers: {})

      get "/api/v0/markets/#{market.id}/nearest_atms", headers: headers

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)
      atm = data[:data][0]
      expect(atm).to be_a Hash

      expect(atm).to have_key(:id)

      expect(atm).to have_key(:attributes)
      expect(atm[:attributes]).to be_a(Hash)

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