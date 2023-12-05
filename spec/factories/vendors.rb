FactoryBot.define do
  factory :vendor do
    name { Faker::TvShows::TwinPeaks.location }
    description { Faker::TvShows::DrWho.quote }
    contact_name { Faker::FunnyName.two_word_name }
    contact_phone { Faker::Number.number(digits: 10) }
    credit_accepted { true }
  end
end
