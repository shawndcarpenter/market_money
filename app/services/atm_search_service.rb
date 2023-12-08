class AtmSearchService
  def find_atm(market)
    conn = Faraday.new("https://api.tomtom.com/search/2/categorySearch/") do |faraday|
      faraday.params["key"] = ENV["API_KEY"]
      faraday.params["lat"] = market.lat
      faraday.params["lon"] = market.lon
      faraday.params["municipality"] = market.city
      faraday.params["streetName"] = market.street
    end

    response = conn.get("automatic_teller_machine.json")
    JSON.parse(response.body, symbolize_names: :true)
  end
end