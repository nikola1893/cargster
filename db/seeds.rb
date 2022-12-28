# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# require "faker"
# require "geocoder"

# User.destroy_all
# Truck.destroy_all
# Load.destroy_all
# puts "Destroyed all users, trucks and loads"

# categories =
# ["", "Хладнњача", "АДР"],
# ["", "Церада", "Мега", "Тандем", "АДР"],
# ["", "Тандем", "АДР", "Камион(под 7.5т)"],
# ["", "Мега", "Камион(под 7.5т)"],
# ["", "Камион(под 7.5т)"],
# ["", "Мега", "Тандем", "АДР"],
# ["", "Цистерна", "Тандем"],
# ["", "Церада", "Тандем"],
# ["", "Церада"],
# ["", "Тандем"],
# ["", "Комбе"],
# ["", "Камион(под 7.5т)"],
# ["", "Цистерна"]



# # generate 50 cities in europe
# europe_cities = ["Skopje, North Macedonia", "Kocani, North Macedonia", "Ohrid, North Macedonia",
# "Prilep, North Macedonia", "Bitola, North Macedonia", "Tetovo, North Macedonia", "Veles, North Macedonia",
# "Belgrade, Serbia", "Novi Sad, Serbia", "Niš, Serbia", "Kragujevac, Serbia", "Subotica, Serbia", "Zrenjanin, Serbia",
# "Podgorica, Montenegro", "Nikšić, Montenegro", "Budva, Montenegro", "Tivat, Montenegro", "Cetinje, Montenegro",
# "Sarajevo, Bosnia and Herzegovina", "Banja Luka, Bosnia and Herzegovina", "Zenica, Bosnia and Herzegovina",
# "Ljubljana, Slovenia", "Maribor, Slovenia", "Celje, Slovenia", "Koper, Slovenia", "Kranj, Slovenia", "Novo Mesto, Slovenia",
# "Zagreb, Croatia", "Split, Croatia", "Rijeka, Croatia", "Osijek, Croatia", "Zadar, Croatia", "Pula, Croatia",
# "Blagoevgrad, Bulgaria", "Burgas, Bulgaria", "Dobrich, Bulgaria", "Gabrovo, Bulgaria", "Haskovo, Bulgaria", "Kardzhali, Bulgaria",
# "Athens, Greece", "Thessaloniki, Greece", "Piraeus, Greece", "Patras, Greece", "Peristeri, Greece", "Heraklion, Greece",
# "Tirana, Albania", "Durres, Albania", "Vlore, Albania", "Elbasan, Albania", "Shkoder, Albania", "Fier, Albania",
# "Prishtina, Kosovo", "Prizren, Kosovo", "Gjakova, Kosovo", "Peja, Kosovo", "Mitrovica, Kosovo", "Ferizaj, Kosovo"]

# # generate 20 users
# (1..5).each do |id|
#   User.create!(
# # each user is assigned an id from 1-20
#       id: id,
#       email: Faker::Internet.email,
# # issue each user the same password
#       password: "password",
#       password_confirmation: "password"
#   )
#   puts "👤 created"
# end

# puts "Created 5 users"

# # generate 50 trucks
# (1..100).each do |id|
#   Truck.create!(
# # each post is assigned an id from 1-100
#       id: id,
#       length: rand(1..14),
#       weight: rand(1..25),
#       comment: Faker::Lorem.paragraph,
#       loading_date: Faker::Date.between(from: Time.now, to: Time.now + 4.days),
#       truck_type: categories.sample,
#       pickup_attributes: {
#         # random city in europe
#         place: europe_cities.sample
#       },
#       dropoff_attributes: {
#         place: europe_cities.sample
#       },
#       status: [true, false].sample,
# # assign each post to a random user
#       user_id: rand(1..5)
#   )
#   puts "🚚 created"
# end

# # generate 50 Load.
# (101..200).each do |id|
#   Load.create!(
# # each post is assigned an id from 1-100
#       id: id,
#       length: rand(1..14),
#       weight: rand(1..25),
#       comment: Faker::Lorem.paragraph,
#       loading_date: Faker::Date.between(from: Time.now, to: Time.now + 4.days),
#       truck_type: categories.sample,
#       pickup_attributes: {
#         # random city in europe
#         place: europe_cities.sample
#       },
#       dropoff_attributes: {
#         place: europe_cities.sample
#       },
#       status: [true, false].sample,
# # assign each post to a random user
#       user_id: rand(1..5)
#   )
#   puts "📦 created"
# end

# # to each truck, asign pickup and dropoff
# puts "Created 100 trucks and loads"
# puts "Finnish 🎉"
