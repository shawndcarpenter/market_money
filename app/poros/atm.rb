class Atm
  attr_reader :name, :address, :lat, :lon, :distance

  def initialize(atm)
    @name = atm[:poi][:name]
    @address = "#{atm[:address][:streetNumber]} #{atm[:address][:streetName]}, #{atm[:address][:municipality]}, #{atm[:address][:countrySubdivision]} #{atm[:address][:postalCode]}"
    @lat = atm[:position][:lat]
    @lon = atm[:position][:lon]
    @distance = atm[:dist]
  end
end