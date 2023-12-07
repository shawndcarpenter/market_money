class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :county, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  def self.search_by_state(state)
    where('lower(state) ilike ?', "%#{state.downcase}%")
  end

  def self.search_by_city_and_state(city, state)
    where('lower(city) ilike ?', "%#{city.downcase}%").where('lower(state) ilike ?', "%#{state.downcase}%")
  end

  def self.search_by_city_and_state_and_name(city, state, name)
    where('lower(city) ilike ?', "%#{city.downcase}%").where('lower(name) ilike ?', "%#{name.downcase}%").where('lower(state) ilike ?', "%#{state.downcase}%")
  end

  def self.search_by_name(name)
    where('lower(name) ilike ?', "%#{name.downcase}%")
  end
  
  def self.search_by_state_and_name(state, name)
    where('lower(state) ilike ?', "%#{state.downcase}%").where('lower(name) ilike ?', "%#{name.downcase}%")
  end
end