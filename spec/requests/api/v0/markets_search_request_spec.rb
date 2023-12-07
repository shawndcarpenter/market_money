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
    # body =  { state: @market1.state, city: @market1.city }
    get "/api/v0/markets/search?city=#{@market1.city}&state=#{@market1.state}" 
    # headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(body)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    markets = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
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
    # body =  { state: @market1.state, city: @market1.city, name: @market1.name }
    get "/api/v0/markets/search?city=#{@market1.city}&state=#{@market1.state}&name=#{@market1.name}" 
    # headers: @headers, params: JSON.generate(body)

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
    # body =  { state: @market1.state, name: @market1.name }
    get "/api/v0/markets/search?state=#{@market1.state}&name=#{@market1.name}" 
    # headers: @headers, params: JSON.generate(body)

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
    # body =  { name: "Bee's Knees" }
    get "/api/v0/markets/search?name=#{@market1.name}" 
    # headers: @headers, params: JSON.generate(body)

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
    # body =  { state: "New Mexico" }
    get "/api/v0/markets/search?state=#{@market1.state}" 
    # headers: @headers, params: JSON.generate(body)

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
end