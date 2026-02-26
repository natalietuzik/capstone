class PlannerItem < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :date, presence: true
  scope :for_date, ->(date) { where(date: date) }
  scope :ordered, -> { order(date: :asc, time_of_day: :asc) }
end
