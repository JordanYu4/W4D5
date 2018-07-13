class User < ApplicationRecord

  validates :username, presence: true, uniqueness: true
  # validates :password,
  validates :password_digest, :session_token, presence: true
  after_initialize :ensure_session_token

  attr_reader :password

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

end
