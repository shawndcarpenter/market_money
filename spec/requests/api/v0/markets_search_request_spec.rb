require 'rails_helper'

describe "Market Search" do
  before :each do
    @market1 = create(:market)
    @market1.vendors = create_list(:vendor, 5)
    @market2 = create(:market)
    @market3 = create(:market)
    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  it "searches for markets in a state and city" do
    get "/api/v0/markets/search?state=#{@market1.state}&city=#{@market1.city}" 

    expect(response).to be_successful
    expect(response.status).to eq(200)

    market = JSON.parse(response.body, symbolize_names: true)[:data].first
    
    expect(market[:id].to_i).to eq(@market1.id)
    expect(market[:type]).to eq("market")
    expect(market[:attributes][:name]).to eq(@market1.name)
    expect(market[:attributes][:street]).to eq(@market1.street)
    expect(market[:attributes][:city]).to eq(@market1.city)
    expect(market[:attributes][:county]).to eq(@market1.county)
    expect(market[:attributes][:state]).to eq(@market1.state)
    expect(market[:attributes][:zip]).to eq(@market1.zip)
    expect(market[:attributes][:lat]).to eq(@market1.lat)
    expect(market[:attributes][:lon]).to eq(@market1.lon)
    expect(market[:attributes][:vendor_count]).to eq(5)
  end

  it "searches for markets in a state, city and with a name" do
    get "/api/v0/markets/search?city=#{@market1.city}&state=#{@market1.state}&name=#{@market1.name}" 

    expect(response).to be_successful
    expect(response.status).to eq(200)

    market = JSON.parse(response.body, symbolize_names: true)[:data].first
    
    expect(market[:id].to_i).to eq(@market1.id)
    expect(market[:type]).to eq("market")
    expect(market[:attributes][:name]).to eq(@market1.name)
    expect(market[:attributes][:street]).to eq(@market1.street)
    expect(market[:attributes][:city]).to eq(@market1.city)
    expect(market[:attributes][:county]).to eq(@market1.county)
    expect(market[:attributes][:state]).to eq(@market1.state)
    expect(market[:attributes][:zip]).to eq(@market1.zip)
    expect(market[:attributes][:lat]).to eq(@market1.lat)
    expect(market[:attributes][:lon]).to eq(@market1.lon)
    expect(market[:attributes][:vendor_count]).to eq(5)
  end

  it "searches for markets in a state with a name" do
    get "/api/v0/markets/search?state=#{@market1.state}&name=#{@market1.name}" 
    
    expect(response).to be_successful
    expect(response.status).to eq(200)

    market = JSON.parse(response.body, symbolize_names: true)[:data].first
    
    expect(market[:id].to_i).to eq(@market1.id)
    expect(market[:type]).to eq("market")
    expect(market[:attributes][:name]).to eq(@market1.name)
    expect(market[:attributes][:street]).to eq(@market1.street)
    expect(market[:attributes][:city]).to eq(@market1.city)
    expect(market[:attributes][:county]).to eq(@market1.county)
    expect(market[:attributes][:state]).to eq(@market1.state)
    expect(market[:attributes][:zip]).to eq(@market1.zip)
    expect(market[:attributes][:lat]).to eq(@market1.lat)
    expect(market[:attributes][:lon]).to eq(@market1.lon)
    expect(market[:attributes][:vendor_count]).to eq(5)
  end

  it "searches for markets in a state" do
    get "/api/v0/markets/search?name=#{@market1.name}" 
    
    expect(response).to be_successful
    expect(response.status).to eq(200)

    market = JSON.parse(response.body, symbolize_names: true)[:data].first
    
    expect(market[:id].to_i).to eq(@market1.id)
    expect(market[:type]).to eq("market")
    expect(market[:attributes][:name]).to eq(@market1.name)
    expect(market[:attributes][:street]).to eq(@market1.street)
    expect(market[:attributes][:city]).to eq(@market1.city)
    expect(market[:attributes][:county]).to eq(@market1.county)
    expect(market[:attributes][:state]).to eq(@market1.state)
    expect(market[:attributes][:zip]).to eq(@market1.zip)
    expect(market[:attributes][:lat]).to eq(@market1.lat)
    expect(market[:attributes][:lon]).to eq(@market1.lon)
    expect(market[:attributes][:vendor_count]).to eq(5)
  end

  it "searches for markets in a state" do
    get "/api/v0/markets/search?state=#{@market1.state}" 
    
    expect(response).to be_successful
    expect(response.status).to eq(200)

    market = JSON.parse(response.body, symbolize_names: true)[:data].first
    
    expect(market[:id].to_i).to eq(@market1.id)
    expect(market[:type]).to eq("market")
    expect(market[:attributes][:name]).to eq(@market1.name)
    expect(market[:attributes][:street]).to eq(@market1.street)
    expect(market[:attributes][:city]).to eq(@market1.city)
    expect(market[:attributes][:county]).to eq(@market1.county)
    expect(market[:attributes][:state]).to eq(@market1.state)
    expect(market[:attributes][:zip]).to eq(@market1.zip)
    expect(market[:attributes][:lat]).to eq(@market1.lat)
    expect(market[:attributes][:lon]).to eq(@market1.lon)
    expect(market[:attributes][:vendor_count]).to eq(5)
  end

  it "will return an empty array if no markets are found with valid search terms" do
    get "/api/v0/markets/search?state=thisisnotarealstate" 
    
    expect(response).to be_successful
    expect(response.status).to eq(200)

    markets = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(markets).to eq([])
  end

  describe "sad paths" do
    it "cannot find a market with only a city" do
      get "/api/v0/markets/search?city=#{@market1.city}" 

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
    end

    it "cannot find a market with only a city and name" do
      get "/api/v0/markets/search?city=#{@market1.city}&name=#{@market1.name}" 
      
      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
    end
  end
end