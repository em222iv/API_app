class Tag < ActiveRecord::Base
  has_and_belongs_to_many :events

  include Rails.application.routes.url_helpers

  def serializable_hash (options={})
    options = {
        # declare what we want to show
        only: [:id, :tag]
    }.update(options)

    json = super(options)
    json['url'] = self_link
    json
  end

  def self_link
    #  the configuration is set i config/enviroment/{development|productions}.rb
    "#{Rails.configuration.baseurl}#{api_tag_path(self)}"
  end
end
