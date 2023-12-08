require 'rails_helper'

describe AtmSearchService do
  before :each do
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
      @search = AtmSearchService.new.find_atm(market)
    end

  context "#search_atms" do
    it "returns atms data that match search criteria" do
      expect(@search).to be_a Hash
      expect(@search[:results]).to be_an Array
      atm_data = @search[:results].first

      expect(atm_data).to have_key :poi
      expect(atm_data[:poi]).to be_a Hash

      expect(atm_data).to have_key :address
      expect(atm_data[:address]).to be_a Hash

      expect(atm_data).to have_key :position
      expect(atm_data[:position]).to be_a Hash
    end
  end
end