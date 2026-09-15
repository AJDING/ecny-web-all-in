class Appointment < ApplicationRecord
  STATUSES = %w[unlocked scheduled completed].freeze
  belongs_to :user
  validates :status, inclusion: { in: STATUSES }

  def scheduled? = status != "unlocked"
  def completed? = status == "completed"
end
