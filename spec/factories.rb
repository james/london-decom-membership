FactoryBot.define do
  factory :event do
    eventbrite_token { 'MyString' }
    eventbrite_id { 'MyString' }
    name { 'London Decompression 2019' }
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
