class Concert < ActiveRecord::Base
  belongs_to :artist
  belongs_to :venue
  has_many :user_concerts
  has_many :users, through: :user_concerts

  def self.our_select(date: date_string, city: city_string, artist: artist_string)
    if date != ""
      date = Date.strptime(date, "%m/%d/%y")
      if city != "" && artist != ""
        artist_id = Artist.where("lower(name) = ?", artist.downcase).map(&:id)
        venue_ids = Venue.where("lower(city) = ?", city.downcase).map(&:id)
        return Concert.where(date: date, venue_id: venue_ids, artist: artist_id)
      elsif artist != ""
        artist_id = Artist.where("lower(name) = ?", artist.downcase).map(&:id)
        return Concert.where(date: date, artist_id: artist_id)
      elsif city != ""
        venue_ids = Venue.where("lower(city) = ?", city.downcase).map(&:id)
        return Concert.where(date: date, venue_id: venue_ids)
      else
        return Concert.where(date: date)
      end
    else
      if city != "" && artist != ""
        artist_id = Artist.where("lower(name) = ?", artist.downcase).map(&:id)
        venue_ids = Venue.where("lower(city) = ?", city.downcase).map(&:id)
        Concert.where(venue_id: venue_ids, artist: artist_id)
      elsif artist != ""
        artist_id = Artist.where("lower(name) = ?", artist.downcase).map(&:id)
        Concert.where(artist_id: artist_id)
      elsif city != ""
        venue_ids = Venue.where("lower(city) = ?", city.downcase).map(&:id)
        Concert.where(venue_id: venue_ids)
      else
        Concert.all
      end
    end
  end

  def to_string
    if min_price != nil
      "Artist: #{artist.name}\nVenue Name: #{venue.name}\nCity: #{venue.city}\nDate: #{date}\nMinimum Ticket Price: #{min_price}\nMaximum Ticket Price: #{max_price}"
    else
      "Artist: #{artist.name}\nVenue Name: #{venue.name}\nCity: #{venue.city}\nDate: #{date}"
    end
  end
end
