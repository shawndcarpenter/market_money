require 'rails_helper'

describe "Markets API" do
  it "sends a list of markets" do
    create_list(:market, 5)

    get '/api/v0/markets'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    markets = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
    expect(markets.count).to eq(5)

    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id].to_i)

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

  it "can get one market by its id" do
    market = create(:market)
    market.vendors = create_list(:vendor, 5)

    get "/api/v0/markets/#{market.id}"

    market = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
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
    expect(market[:attributes][:vendor_count]).to eq(5)
  end

  describe "sad paths" do
    it "will gracefully handle if a market id doesn't exist" do
      get "/api/v0/markets/123123123123"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end
end