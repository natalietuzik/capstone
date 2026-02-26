class TodoItem < ApplicationRecord
  belongs_to :user

  PRIORITIES = { 1 => "Low", 2 => "Medium", 3 => "High" }.freeze

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES.keys }

  scope :pending,   -> { where(completed: false) }
  scope :done,      -> { where(completed: true) }
  scope :ordered,   -> { order(completed: :asc, priority: :desc, created_at: :asc) }
end
