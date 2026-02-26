class User < ApplicationRecord
  has_secure_password
  has_many :planner_items, dependent: :destroy
  has_many :medications, dependent: :destroy
  has_many :medication_logs, dependent: :destroy
  has_many :mental_health_entries, dependent: :destroy
  has_many :journal_entries, dependent: :destroy
  has_many :todo_items, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: true

  before_save { self.email = email.downcase }

  attr_accessor :remember_token

  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    update_column(:remember_digest, BCrypt::Password.create(remember_token))
  end

  def authenticated?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def forget
    update_column(:remember_digest, nil)
  end
end
