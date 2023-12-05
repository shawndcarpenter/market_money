require 'rails_helper'

describe "Market Vendors" do
  it "sends a list of vendors for a particular market" do
    market = create(:market)
    id = market.id
    market.vendors = FactoryBot.create_list(:vendor, 5)

    get "/api/v0/markets/#{id}/vendors"

    expect(response).to be_successful

    vendors = JSON.parse(response.body, symbolize_names: true)

    expect(vendors[:data].count).to eq(5)

    vendors[:data].each do |vendor|
      # expect(vendor).to have_key(:id)
      # expect(vendor[:id]).to eq(id)

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
end