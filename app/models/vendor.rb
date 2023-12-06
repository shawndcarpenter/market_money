class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :contact_name
  validates_presence_of :contact_phone
  validate :does_not_have_a_boolean
  # validate :name_is_empty
  # validate :contact_name_is_empty
  # validate :contact_phone_is_empty
  # validate :description_is_empty

  def does_not_have_a_boolean
    if credit_accepted != true && credit_accepted != false
      errors.add(:credit_accepted, "can't be blank")
    end
  end

  # def name_is_empty
  #   if name == ""
  #     errors.add(:name, "can't be blank")
  #   end
  # end

  # def contact_name_is_empty
  #   if contact_name == ""
  #     errors.add(:contact_name, "can't be blank")
  #   end
  # end

  # def contact_phone_is_empty
  #   if contact_phone == ""
  #     errors.add(:contact_phone, "can't be blank")
  #   end
  # end

  # def description_is_empty
  #   if description == ""
  #     errors.add(:description, "can't be blank")
  #   end
  # end
end
