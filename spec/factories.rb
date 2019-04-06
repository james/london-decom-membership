FactoryBot.define do
  factory :volunteer_role do
    name { 'MyString' }
    description { 'MyText' }
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
