10.times do
  Artist.create(name: Faker::Music.band, genre: Faker::Music.genre)
end

10.times do
  Venue.create(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr)
end

50.times do
  min_price = rand(50.0...100.0).round(2)
  max_price = rand(101.0...500.0).round(2)

  Concert.create(artist_id: Artist.all.sample.id, venue_id: Venue.all.sample.id, date: Faker::Date.forward(100), min_price: min_price, max_price: max_price)
end
