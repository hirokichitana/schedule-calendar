FactoryBot.define do
  factory :user do
    name                  { Faker::Name.initials }
    telephone_number      { Faker::Number.number(digits: 11) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: '2017-12-31') }
  end
end
