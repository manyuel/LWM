# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'faker'

User.destroy_all

puts "Creating users..."

20.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.safe_email,
    password: '123456',
    city: 'London',
    batch: 1051
  )
  file = URI.open('https://thispersondoesnotexist.com/image')
  user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

puts "Done!"
