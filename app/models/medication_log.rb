class MedicationLog < ApplicationRecord
  belongs_to :user
  belongs_to :medication
  validates :date, presence: true
  validates :medication_id, uniqueness: { scope: [:user_id, :date], message: "already logged for this date" }
end
