require 'rails_helper'

describe "Vendor API Request" do
  it "sends a vendor" do
    vendor = create(:vendor)
    id = vendor.id

    get "/api/v0/vendors/#{id}"

    expect(response).to be_successful

    vendor = JSON.parse(response.body, symbolize_names: true)[:data]

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

  describe "sad paths" do
    it "will gracefully handle if a vendor id doesn't exist" do
      get "/api/v0/vendors/123123123123"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=123123123123")
    end
  end
end