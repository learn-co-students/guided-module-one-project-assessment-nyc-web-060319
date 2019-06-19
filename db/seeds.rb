require "dotenv"
Dotenv.load("api_key.env")
api_key = ENV["API_KEY"]

# seeded database initially, commented out so as not to repeat entries

# 10.times do
#   Artist.create(name: Faker::Music.band, genre: Faker::Music.genre)
# end

# 10.times do
#   Venue.create(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr)
# end

# 50.times do
#   min_price = rand(50.0...100.0).round(2)
#   max_price = rand(101.0...500.0).round(2)

#   Concert.create(artist_id: Artist.all.sample.id, venue_id: Venue.all.sample.id, date: Faker::Date.forward(100), min_price: min_price, max_price: max_price)
# end

# set the user of all initial seed data to master user

# master_u = User.find_by(username: "AE")

# Artist.all.each do |artist|
#   artist.user = master_u
#   artist.save
# end

# Concert.all.each do |concert|
#   concert.user = master_u
#   concert.save
# end

# Venue.all.each do |venue|
#   venue.user = master_u
#   venue.save
# end

# User.find_or_create_by(username: "AE", password: "masterpass")

# require_relative "../db/scrape_api.rb"

# require_relative "fix_venue_duplicates.rb"
