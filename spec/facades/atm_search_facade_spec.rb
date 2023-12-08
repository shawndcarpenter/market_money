require 'rails_helper'

describe AtmSearchFacade do
  context "class methods" do
    context "#atm_search" do
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
          @facade = AtmSearchFacade.new(market)
        end

        it "exists" do
          expect(@facade.class).to be(AtmSearchFacade)
        end

        it "can create poros of atms based on search terms" do
          @facade.atms.each do |atm|
            expect(atm).to be_a(Atm)
            expect(atm).to respond_to(:name)
            expect(atm).to respond_to(:address)
            expect(atm).to respond_to(:lat)
            expect(atm).to respond_to(:lon)
            expect(atm).to respond_to(:distance)
          end
        end
    end
  end
end