class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, email: true, uniqueness: { case_sensitive: false }
  has_secure_password
  # Returns the hash digest of the given string.
end

