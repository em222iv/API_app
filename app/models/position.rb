class Position < ActiveRecord::Base
  reverse_geocoded_by :lat, :long

  has_many :events
  include Rails.application.routes.url_helpers

  def serializable_hash (options={})
    options = {
        # declare what we want to show
        only: [:id,:lat,:long]
    }.update(options)
    json = super(options)
    json['url'] = self_link
    json
  end
  def self_link
    #  set in config/enviroment/{development|productions}.rb
    "#{Rails.configuration.baseurl}#{api_position_path(self)}"
  end
end
