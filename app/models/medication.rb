class Medication < ApplicationRecord
  belongs_to :user
  has_many :medication_logs, dependent: :destroy
  validates :name, presence: true
end
