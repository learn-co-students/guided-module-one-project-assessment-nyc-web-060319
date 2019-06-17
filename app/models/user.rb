class User < ActiveRecord::Base
  has_many :artists
  has_many :venues
  has_many :concerts
end
