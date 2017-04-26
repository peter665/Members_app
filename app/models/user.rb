class User < ApplicationRecord

  attr_accessor :remember_token

  before_create :create_remember_digest

  has_secure_password

  has_many :posts

  def self.digest(token)
    Digest::SHA1.hexdigest(token)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_remember_digest
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token.to_s)
  end

  def authenticated? attribute, token
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

end
