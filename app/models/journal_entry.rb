class JournalEntry < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :date, presence: true

  scope :ordered, -> { order(date: :desc) }
end
