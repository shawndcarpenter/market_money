FactoryBot.define do
  factory :market do
    name { Faker::TvShows::TwinPeaks.location }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Address.street_name }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end
