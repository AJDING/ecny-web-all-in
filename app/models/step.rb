class Step < ApplicationRecord
  has_many :lessons, -> { order(:position) }, dependent: :destroy
  has_many :assessments, -> { order(:position) }, dependent: :destroy
  validates :position, :slug, :title, presence: true
  scope :ordered, -> { order(:position) }

  def ordinal_word = %w[Zero One Two Three Four Five][position]
end
