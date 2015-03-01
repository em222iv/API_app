class Position < ActiveRecord::Base
  reverse_geocoded_by :lat, :long
  after_validation :reverse_geocode  # auto-fetch address
  has_many :events
  include Rails.application.routes.url_helpers

  def serializable_hash (options={})
    options = {
        # declare what we want to show
        only: [:id, :lat,:long]
    }.update(options)

    json = super(options)
    json['url'] = self_link
    json
  end

  def self_link
    #  the configuration is set i config/enviroment/{development|productions}.rb
    "#{Rails.configuration.baseurl}#{api_position_path(self)}"
  end
end
