class Position < ActiveRecord::Base
  reverse_geocoded_by :lat, :long
  belongs_to :event
end
