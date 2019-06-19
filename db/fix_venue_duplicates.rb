# bad_bowery_concerts = Venue.find(68).concerts
# bad_bowery_concerts.each do |concert|
#   concert.venue_id = 57
# end

# Venue.find(68).destroy

Concert.where(venue_id: 68).each do |concert|
  concert.venue_id = 57
  concert.save
end

# bad_brooklyn_steel_concerts = Venue.find(76).concerts
# bad_brooklyn_steel_concerts.each do |concert|
#   concert.venue_id = 71
# end

# Venue.find(76).destroy

Concert.where(venue_id: 76).each do |concert|
  concert.venue_id = 71
  concert.save
end

# bad_forest_hills_concerts = Venue.find(56).concerts
# bad_forest_hills_concerts.each do |concert|
#   concert.venue_id = 18
# end

# Venue.find(56).destroy

Concert.where(venue_id: 56).each do |concert|
  concert.venue_id = 18
  concert.save
end

# bad_avant_gardner_concerts = Venue.find(96).concerts
# bad_avant_gardner_concerts.each do |concert|
#   concert.venue_id = 107
# end

# Venue.find(96).destroy

Concert.where(venue_id: 96).each do |concert|
  concert.venue_id = 107
  concert.save
end

# bad_sob_concerts = Venue.find(102).concerts
# bad_sob_concerts.each do |concert|
#   concert.venue_id = 101
# end

# Venue.find(102).destroy

Concert.where(venue_id: 102).each do |concert|
  concert.venue_id = 101
  concert.save
end

# bad_chance_concerts = Venue.find(62).concerts
# bad_chance_concerts.each do |concert|
#   concert.venue_id = 66
# end

# Venue.find(62).destroy

Concert.where(venue_id: 62).each do |concert|
  concert.venue_id = 66
  concert.save
end

# bad_warsaw_concerts = Venue.find(92).concerts
# bad_warsaw_concerts.each do |concert|
#   concert.venue_id = 109
# end

# Venue.find(92).destroy

Concert.where(venue_id: 92).each do |concert|
  concert.venue_id = 109
  concert.save
end
