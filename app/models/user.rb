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
end
