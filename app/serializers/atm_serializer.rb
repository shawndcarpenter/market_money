class AtmSerializer

  def self.format_atms(atms)
    { data:
      atms.map do |atm|
        {
          id: "null",
          type: "atm",
          attributes: {
              name: "ATM",
              address: "#{atm.address}",
              lat: atm.lat,
              lon: atm.lon,
              distance: atm.distance
          }
        }
      end
    }
  end
end