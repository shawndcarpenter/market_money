class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :contact_name
  validates_presence_of :contact_phone
  validate :does_not_have_a_boolean

  def does_not_have_a_boolean
    if credit_accepted != true && credit_accepted != false
      errors.add(:credit_accepted, "can't be blank")
    end
  end
end
