class Venue < ActiveRecord::Base
  has_many :concerts
  has_many :artists, through: :concerts
  belongs_to :user
end
