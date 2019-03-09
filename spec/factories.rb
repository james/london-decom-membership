FactoryBot.define do
  factory :user do
    name { 'James Darling' }
    email { 'james@abscond.org' }
    password { 'password' }
    confirmed_at { Time.zone.now }
  end
end
