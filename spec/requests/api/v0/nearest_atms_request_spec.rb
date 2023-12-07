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

  describe "sad path, invalid market id" do
    it "will generate an error message if market id is invalid" do
      get "/api/v0/markets/123123123123/nearest_atms", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_an(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end
end