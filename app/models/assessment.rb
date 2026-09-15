class Assessment < ApplicationRecord
  belongs_to :step
  has_many :questions, -> { order(:position) }, dependent: :destroy
  has_many :assessment_results, dependent: :destroy

  validates :position, :slug, :title, presence: true
  scope :ordered, -> { order(:position) }

  def to_param = slug
  def question_count = questions.size

  # Returns [[category, score], ...] sorted high to low for a result.
  def ranked(result)
    result.scores.sort_by { |_, v| -v }
  end

  def category_info(name)
    (categories[name] || {}).with_indifferent_access
  end
end
