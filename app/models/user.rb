class User < ActiveRecord::Base
  has_many :user_concerts
  has_many :concerts, through: :user_concerts
end
