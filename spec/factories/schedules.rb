FactoryBot.define do
  factory :schedule do


    title             { Faker::Lorem.word }
    content           { Faker::Lorem.sentence }
    start_time        { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end_time          { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    zip_code          { '123-4567' }
    prefecture        { '三重県' }
    city              { Faker::Address.city }
    town              { Faker::Address.street_address }
    building_name     { 'ハイツ' }
    association :user
  end
end
