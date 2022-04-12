FactoryBot.define do
  factory :schedule do

    Faker::Config.locale = :ja

    title             { Faker::Lorem.word }
    content           { Faker::Lorem.sentence }
    start_time        { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end_time          { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    zip_code          { Faker::Address.zip_code }
    prefecture        { Faker::Address.state }
    city              { Faker::Address.city }
    town              { Faker::Address.street_address }
    building_name     { Faker::Address.building_number }
    association :user
  end
end
