require 'rails_helper'

describe "Market Vendors" do
  it "sends a list of vendors for a particular market" do
    market = create(:market)
    id = market.id
    market.vendors = FactoryBot.create_list(:vendor, 5)

    get "/api/v0/markets/#{id}/vendors"

    expect(response).to be_successful

    vendors = JSON.parse(response.body, symbolize_names: true)
  end
end