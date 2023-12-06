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
      expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=123123123123")
    end
  end

  describe "vendor create" do
    it "Can post to vendors" do
      vendor_params = ({
        name: "Buzzy Bees",
        description: "local honey and wax products",
        contact_name: "Berly Couwer",
        contact_phone: "8389928383",
        credit_accepted: true
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
    vendor = Vendor.last

    expect(response).to be_successful
    # expect(response.status).to eq(201)
      
    
      expect(vendor.name).to eq(vendor_params[:name])
      expect(vendor.description).to eq(vendor_params[:description])
      expect(vendor.contact_name).to eq(vendor_params[:contact_name])
      expect(vendor.contact_phone).to eq(vendor_params[:contact_phone])
      expect(vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
      # expect(vendor).to have_key(:type)
      # expect(vendor[:type]).to be_a(String)
      # expect(vendor[:type]).to eq("vendor")
      
      # expect(vendor).to have_key(:attributes)
      # expect(vendor[:attributes]).to be_an(Hash)
      
      # expect(vendor[:attributes]).to have_key(:name)
      # expect(vendor[:attributes][:name]).to be_a(String)
      
      # expect(vendor[:attributes]).to have_key(:description)
      # expect(vendor[:attributes][:description]).to be_a(String)
      
      # expect(vendor[:attributes]).to have_key(:contact_name)
      # expect(vendor[:attributes][:contact_name]).to be_a(String)
      
      # expect(vendor[:attributes]).to have_key(:contact_phone)
      # expect(vendor[:attributes][:contact_phone]).to be_a(String)
      
      # expect(vendor[:attributes]).to have_key(:credit_accepted)
      # expect(vendor[:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)

    end
    
    describe "sad path" do
      it "will return details in error message" do
        vendor_params = ({
          name: "Buzzy Bees",
          description: "local honey and wax products",
          credit_accepted: false
      })
      headers = {"CONTENT_TYPE" => "application/json"}
  
      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
      end
    end
  end

  describe "vendor update" do
    before :each do
      vendor_params = ({
        name: "Buzzy Bees",
        description: "local honey and wax products",
        contact_name: "Berly Couwer",
        contact_phone: "8389928383",
        credit_accepted: true
      })
      headers = {"CONTENT_TYPE" => "application/json"}
  
      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
      @vendor = Vendor.last
    end

    it "can update an existing vendor" do
      new_vendor_params = {
        contact_name: "Kimberly Couwer",
        credit_accepted: false
        }

      patch "/api/v0/vendors/#{@vendor.id}",  
        headers: headers, params: JSON.generate({vendor: new_vendor_params})
      vendor = Vendor.last

      expect(response).to be_successful
      expect(vendor.contact_name).to_not eq("Berly Couwer")
      expect(vendor.contact_name).to eq("Kimberly Couwer")
      expect(vendor.credit_accepted).to eq(false)
    end

    describe "vendor update sad paths" do
      it "gives an error when vendor id is invalid" do
        patch "/api/v0/vendors/123123123123",
        headers: headers, params: JSON.generate( {
          "contact_name": "Kimberly Couwer",
          "credit_accepted": false
        })

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=123123123123")
      end

      xit "gives an error when an update parameter is blank" do
        patch "/api/v0/vendors/#{@vendor.id}",
        headers: headers, params: JSON.generate( {
          contact_name: "",
          credit_accepted: false
        })

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:detail]).to eq("Validation failed: Contact name can't be blank")
      end
    end
  end

  describe "vendor delete" do
    it "can delete a vendor" do
      vendor = create(:vendor)

      expect(Vendor.count).to eq(1)

      delete "/api/v0/vendors/#{vendor.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(Vendor.count).to eq(0)
      expect{Vendor.find(vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    describe "vendor delete sad paths" do
      it "gives an error when vendor id is invalid" do
        delete "/api/v0/vendors/123123123123"

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_an(Array)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=123123123123")
      end
    end
  end
end