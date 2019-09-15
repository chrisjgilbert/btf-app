class User < ApplicationRecord
  attr_accessor :password_reset_token

  has_one :team, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  before_save { email.downcase! }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 255 }
  validates :email,      presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password,   length: { minimum: 6, maximum: 77 }

  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def create_password_reset_digest
    self.password_reset_token = User.new_token
    update_columns(password_reset_digest: User.digest(password_reset_token), password_reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def authenticated_for_password_reset?(token)
    return false if self.password_reset_digest.nil?

    BCrypt::Password.new(self.password_reset_digest).is_password?(token)
  end

  def password_reset_expired?
    password_reset_sent_at < 2.hours.ago
  end

  def destroy_password_reset_digest
    update_columns(password_reset_digest: nil, password_reset_sent_at: nil)
  end

  def has_created_a_team?
    Team.where(user_id: self.id).exists?
  end

end
