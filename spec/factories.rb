FactoryBot.define do
  factory :low_income_request do
    user
    request_reason { 'MyText' }
    status { '' }
  end

  factory :low_income_code do
    code { '1234' }
    low_income_request { nil }
  end

  factory :event do
    eventbrite_token { 'MyString' }
    eventbrite_id { 'MyString' }
    name { 'London Decompression 2019' }
    active { true }
  end

  factory :volunteer do
    user
    volunteer_role
  end

  factory :volunteer_role do
    name { 'MyString' }
    description { 'MyText' }
    event
  end

  factory :membership_code do
    code { '1234' }
    user { nil }
  end

  factory :user do
    name { 'James Darling' }
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password { 'password' }
    confirmed_at { Time.zone.now }
  end
end
