# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'faker'

Product.destroy_all
User.destroy_all

puts "Creating users..."


products = ["Elephant Bike", "Mug", "Frying Pan"]
conditions = ["excellent", "good", "okay", "bad"]

3.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.safe_email,
    city: "London",
    batch: 1051,
    password: '123456'
  )
  puts "User Created"

  puts "Creating Product..."
  i = 0

  3.times do
    product = Product.new(
      item: products[i],
      price: rand(1.99..49.99),
      description: "#{products[i]} in #{conditions.sample} condition. No longer needed as I'm moving back home",
      user_id: user.id
    )

    user_file = URI.open('https://thispersondoesnotexist.com/image')
    user.photo.attach(io: user_file, filename: "#{user.name}.jpg", content_type: 'image/jpg')
    product_file1 = open("app/assets/images/#{products[i]}1.jpg")
    product.photos.attach(io: product_file1, filename: "#{products[i].strip.gsub(/\s+/, "_")}1.jpg", content_type: 'image/jpg')
    product_file2 = open("app/assets/images/#{products[i]}2.jpg")
    product.photos.attach(io: product_file2, filename: "#{products[i].strip.gsub(/\s+/, "_")}2.jpg", content_type: 'image/jpg')
    product_file3 = open("app/assets/images/#{products[i]}3.jpg")
    product.photos.attach(io: product_file3, filename: "#{products[i].strip.gsub(/\s+/, "_")}3.jpg", content_type: 'image/jpg')

    product.save!
    i += 1

    puts "Product Created"
  end
  puts "Done!"
end
