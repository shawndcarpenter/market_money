class AtmSearchFacade
  def initialize(market)
    @market = market
  end

  def atms
    service = AtmSearchService.new

    json = service.find_atm(@market)
    @atms = json[:results].map do |atm_data|
      Atm.new(atm_data)
    end
  end
end