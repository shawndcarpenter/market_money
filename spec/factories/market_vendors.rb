# FactoryBot.define do
#   factory :vendor do
#     name { Faker::Company.name }
#     description { Faker::TvShows::DrWho.quote }
#     contact_name { Faker::TvShows::DrWho.character }
#     contact_phone { Faker::Number.number(digits: 10) }
#     credit_accepted { Faker::Boolean.boolean }
#   end

#   factory :market do
#     name { Faker::TvShows::TwinPeaks.location }
#     street { Faker::Address.street_address }
#     city { Faker::Address.city }
#     county { Faker::Address.street_name }
#     state { Faker::Address.state }
#     zip { Faker::Address.zip }
#     lat { Faker::Address.latitude }
#     lon { Faker::Address.longitude }

#     after(:create) do |market|
#       market.vendors = FactoryBot.create_list(:vendor, 5)
#     end
#   end
# end
