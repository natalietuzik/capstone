class MentalHealthEntry < ApplicationRecord
  belongs_to :user
  validates :date, presence: true
  validates :mood, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :anxiety, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :date, uniqueness: { scope: :user_id, message: "already has an entry for this date" }
end
