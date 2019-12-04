class User < ApplicationRecord
  attr_accessor :password_reset_token, :activation_token

  has_one :team, dependent: :destroy
  has_one :league, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  before_save :downcase_email
  before_create :create_activation_digest

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

  def self.update_payment_status_to_true(email)
    user = find_by_email(email)
    return p "Can't find a user with email #{email}" unless user.present?
    return p "User with email #{email} has already paid" if user.payment_status == true

    user.update_columns(payment_status: true)
    p "#{user.email} payment status is now #{user.payment_status}"
  end

  def create_password_reset_digest
    self.password_reset_token = User.new_token
    update_columns(password_reset_digest: User.digest(password_reset_token), password_reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
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

  def has_created_a_league?
    League.where(user_id: self.id).exists?
  end

  def owns_league?(league_id)
    League.where(id: league_id, user_id: self.id).exists?
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def downcase_email
    email.downcase!
  end
end
