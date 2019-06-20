class Concert < ActiveRecord::Base
  belongs_to :artist
  belongs_to :venue
  has_many :user_concerts
  has_many :users, through: :user_concerts

  def self.our_select(date1: begin_date_string, date2: end_date_string, city: city_string, artist: artist_string)
    if date1 != ""
      begin_date = Date.strptime(date1, "%m/%d/%y")
      end_date = Date.strptime(date2, "%m/%d/%y")
      date_range = begin_date..end_date

      if city != "" && artist != ""
        artist_id = Artist.where("lower(name) = ?", artist.downcase).map(&:id)
        venue_ids = Venue.where("lower(city) = ?", city.downcase).map(&:id)
        return Concert.where(date: date_range, venue_id: venue_ids, artist: artist_id)
      elsif artist != ""
        artist_id = Artist.where("lower(name) = ?", artist.downcase).map(&:id)
        return Concert.where(date: date_range, artist_id: artist_id)
      elsif city != ""
        venue_ids = Venue.where("lower(city) = ?", city.downcase).map(&:id)
        return Concert.where(date: date_range, venue_id: venue_ids)
      else
        return Concert.where(date: date_range)
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
