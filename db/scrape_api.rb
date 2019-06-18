require "dotenv"
require "rest-client"
require "json"

Dotenv.load("api_key.env")
api_key = ENV["API_KEY"]

def make_artist_hash(attractions_hash)
  new_hash = {}
  new_hash[:name] = attractions_hash["name"]
  new_hash[:genre] = attractions_hash["classifications"][0]["subGenre"]["name"]
  new_hash[:user_id] = 1
  new_hash
end

def make_venue_hash(raw_venue_hash)
  new_hash = {}
  new_hash[:name] = raw_venue_hash["name"]
  new_hash[:address] = raw_venue_hash["address"]["line1"]
  new_hash[:city] = raw_venue_hash["city"]["name"]
  new_hash[:state] = raw_venue_hash["state"]["stateCode"]
  new_hash[:user_id] = 1
  new_hash
end

url_1 = "https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&dmaId=345&apikey=#{api_key}"
url_2 = "https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&dmaId=345&page=4&apikey=#{api_key}"
url = "https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&dmaId=345&page=8&apikey=#{api_key}"
4.times do
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
  response_hash["_embedded"]["events"].each do |event_hash|
    artist_hash = make_artist_hash(event_hash["_embedded"]["attractions"][0])
    new_artist = Artist.find_or_create_by(artist_hash)

    venue_hash = make_venue_hash(event_hash["_embedded"]["venues"][0])
    new_venue = Venue.find_or_create_by(venue_hash)

    concert_hash = {}
    concert_hash[:date] = Date.strptime(event_hash["dates"]["start"]["localDate"])
    if event_hash["priceRanges"]
      concert_hash[:min_price] = event_hash["priceRanges"][0]["min"]
      concert_hash[:max_price] = event_hash["priceRanges"][0]["max"]
    end

    concert_hash[:artist_id] = new_artist.id
    concert_hash[:venue_id] = new_venue.id
    concert_hash[:user_id] = 1
    Concert.find_or_create_by(concert_hash)
  end
  url = "https://app.ticketmaster.com#{response_hash["_links"]["next"]["href"]}&apikey=#{api_key}"
  puts url
end
