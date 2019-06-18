class Concert < ActiveRecord::Base
  belongs_to :artist
  belongs_to :venue
  belongs_to :user

  def self.our_select(date: date_string, city: city_string, artist: artist_string)
    if date != ""
      date = Date.strptime(date, "%m/%d/%y")
      if city != "" && artist != ""
        artist_id = Artist.find_by(name: artist).id
        venue_ids = Venue.where(city: city).map(&:id)
        return Concert.where(date: date, venue_id: venue_ids, artist: artist_id)
      elsif artist != ""
        artist_id = Artist.find_by(name: artist).id
        return Concert.where(date: date, artist_id: artist_id)
      elsif city != ""
        venue_ids = Venue.where(city: city).map(&:id)
        return Concert.where(date: date, venue_id: venue_ids)
      else
        return Concert.where(date: date)
      end
    else
      if city != "" && artist != ""
        artist_id = Artist.find_by(name: artist).id
        venue_ids = Venue.where(city: city).map(&:id)
        Concert.where(venue_id: venue_ids, artist: artist_id)
      elsif artist != ""
        artist_id = Artist.find_by(name: artist).id
        Concert.where(artist_id: artist_id)
      elsif city != ""
        venue_ids = Venue.where(city: city).map(&:id)
        Concert.where(venue_id: venue_ids)
      else
        Concert.all
      end
    end
  end

  def to_string
    "Artist: #{artist.name}\nCity: #{venue.city}\nDate: #{date}\nMinimum Ticket Price: #{min_price}\nMaximum Ticket Price: #{max_price}"
  end
end
