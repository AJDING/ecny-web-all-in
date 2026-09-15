class Question < ApplicationRecord
  belongs_to :assessment
  validates :position, :category, :text, presence: true
end
