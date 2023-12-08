require 'rails_helper'

RSpec.describe VendorSerializer, type: :request do
  describe "serializing" do
    it "can work" do
      vendor = create(:vendor)
      headers = {"CONTENT_TYPE" => "application/json"}

      get "/api/v0/vendors/#{vendor.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      vendor = JSON.parse(response.body, symbolize_names: true)[:data]
  
      expect(vendor).to have_key(:id)
      expect(vendor[:id].to_i).to be_a Integer
  
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