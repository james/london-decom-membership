# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

case Rails.env
when "development"
  require 'faker'
  100.times do |id|
    name = Faker::Name.name
    User.create!(
      email: Faker::Internet.email(name: name, domain: 'dev.decomsite.com'),
      name: name,
      admin: false,
      marketing_opt_in: false,
      early_access: false,
      ticket_bought: nil,
      password: "password"
    )
  end
end
