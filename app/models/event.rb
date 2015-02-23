class Event < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :creators
  has_many :positions
end
