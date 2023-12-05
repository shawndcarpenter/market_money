FactoryBot.define do
  factory :vendor do
    name { Faker::TvShows::TwinPeaks.location }
    description { Faker::TvShows::DrWho.quote }
    contact_name { Faker::TvShows::DrWho.character }
    contact_phone { Faker::Number.number(digits: 10) }
    credit_accepted { Faker::Boolean.boolean }
  end
end
