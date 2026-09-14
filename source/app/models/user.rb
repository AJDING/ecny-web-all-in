class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :lesson_completions, dependent: :destroy
  has_many :completed_lessons, through: :lesson_completions, source: :lesson
  has_many :assessment_results, dependent: :destroy
  has_one  :appointment, dependent: :destroy

  validates :first_name, :last_name, presence: true
  normalizes :first_name, :last_name, with: ->(v) { v.strip }

  def full_name = "#{first_name} #{last_name}"
  def initials  = "#{first_name.first}#{last_name.first}".upcase

  def completed?(lesson) = completed_lesson_ids.include?(lesson.id)
  def completed_lesson_ids = @completed_lesson_ids ||= lesson_completions.pluck(:lesson_id)

  def result_for(assessment)
    assessment_results.find { |r| r.assessment_id == assessment.id }
  end

  def pathway = @pathway ||= Pathway.new(self)
end
