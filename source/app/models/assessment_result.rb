class AssessmentResult < ApplicationRecord
  SCALE = { 1 => "Rarely", 2 => "Occasionally", 3 => "Sometimes", 4 => "Often", 5 => "Almost always" }.freeze

  belongs_to :user
  belongs_to :assessment

  validates :assessment_id, uniqueness: { scope: :user_id }

  # answers: { "question_id" => "1".."5" }
  def self.build_from(user:, assessment:, answers:)
    questions = assessment.questions.index_by { |q| q.id.to_s }
    clean = answers.to_h.slice(*questions.keys).transform_values { |v| v.to_i.clamp(1, 5) }
    scores = Hash.new(0)
    clean.each { |qid, v| scores[questions[qid].category] += v }
    # Normalise to 0-100 so categories with different question counts compare fairly.
    per_cat = questions.values.group_by(&:category).transform_values(&:size)
    pct = scores.to_h { |cat, total| [cat, ((total.to_f / (per_cat[cat] * 5)) * 100).round] }
    find_or_initialize_by(user:, assessment:).tap do |r|
      r.answers = clean
      r.scores  = pct
      r.completed_at = Time.current if clean.size == questions.size
    end
  end

  def complete? = completed_at.present?
  def top(n = assessment.top_n) = scores.sort_by { |_, v| -v }.first(n)
end
