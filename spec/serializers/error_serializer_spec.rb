require 'rails_helper'

RSpec.describe ErrorSerializer, type: :request do
  describe "serializing" do
    it "can work" do 
      get "/api/v0/markets/123123123123"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end
end