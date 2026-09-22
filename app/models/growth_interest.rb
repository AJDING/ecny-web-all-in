class GrowthInterest < ApplicationRecord
  belongs_to :user
  belongs_to :assessment
  validates :category, presence: true, uniqueness: { scope: %i[user_id assessment_id] }
end
