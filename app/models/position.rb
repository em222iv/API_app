class Position < ActiveRecord::Base
  reverse_geocoded_by :lat, :long
  after_validation :reverse_geocode  # auto-fetch address
  has_many :events
end
