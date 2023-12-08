require "rails_helper"

RSpec.describe Atm do
  it "exists" do
    atms_near_nob_hill_fixture = File.read("spec/fixtures/atms_near_nob_hill.json")

    atm = Atm.new(JSON.parse(atms_near_nob_hill_fixture, symbolize_names: true)[:results].first)
    expect(atm).to be_a Atm
    expect(atm.name).to eq("ATM")
    expect(atm.address).to eq("3902 Central Avenue Southeast, Albuquerque, NM 87108")
    expect(atm.lat).to eq(35.079044)
    expect(atm.lon).to eq(-106.60068)
    expect(atm.distance).to eq(169.766658)
  end
end